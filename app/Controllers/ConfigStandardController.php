<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use RuntimeException;

class ConfigStandardController extends BaseController
{
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;
    protected StandardModel $standardModel;
    protected RequirementModel $requirementModel;

    public function __construct()
    {
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->sectorModel = new SectorModel();
        $this->standardModel = new StandardModel();
        $this->requirementModel = new RequirementModel();
    }

    private function loadConfigData()
    {
        return [
            'industries' => $this->industryModel->getIndustries(),
            'sectors' => $this->sectorModel->getSectors(),
            'standards' => $this->standardModel->getStandards(),
            'requirements' => $this->requirementModel->getRequirements(),
            'countries' => $this->countryModel->getCountries(),
        ];
    }

    //--------------------
    // Standard Methods
    //--------------------

    // Zeigt die Liste der Standards an
    public function standard()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_standard', $data);
        echo view('templates/footer');
    }

    // Funktion zum Anlegen eines neuen Standards
    public function createStandard()
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('message', 'Keine Berechtigung.');
        }

        if (! $this->validate('standard')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openStandardModal', true);
        }

        $data = [
            'code'       => $this->request->getPost('code'),
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
            'description_eng' => $this->request->getPost('description_eng'),
        ];

        try {
            $this->standardModel->createStandard($data);

            return redirect()
                ->to('/config/standard')
                ->with('success', 'Standard erfolgreich angelegt.');
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openStandardModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    // Funktion zum Aktualisieren eines Standards
    public function updateStandard($standard_id)
    {
        if (! $this->validate('standard')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openStandardModal', true);
        }

        $data = [
            'code'       => $this->request->getPost('code'),
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
            'description_eng' => $this->request->getPost('description_eng'),
        ];

        try {
            $this->standardModel->updateStandard($standard_id, $data);

            return redirect()
                ->to('/config/standard')
                ->with('success', 'Standard erfolgreich aktualisiert.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openStandardModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    // Funktion zum Löschen eines Standards
    public function deleteStandard($standard_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->standardModel->deleteStandard($standard_id);

            return redirect()
                ->to('/config/standard')
                ->with('success', 'Standard erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/standard')
                ->with('error', $exception->getMessage());
        }
    }
}
