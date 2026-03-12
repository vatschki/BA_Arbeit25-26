<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use RuntimeException;

class ConfigIndustryController extends BaseController
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
    // Industry Methods
    //--------------------

    // Zeigt die Liste der Industrien an
    public function industry()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_industry', $data);
        echo view('templates/footer');
    }

    // Funktion zum Anlegen einer neuen Industrie
    public function createIndustry()
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('message', 'Keine Berechtigung.');
        }

        if (! $this->validate('industry')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openIndustryModal', true);
        }

        $data = [
            'sector_id'  => $this->request->getPost('sector_id'),
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->industryModel->createIndustry($data);

            return redirect()
                ->to('/config/industry')
                ->with('success', 'Industrie erfolgreich angelegt.');
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openIndustryModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    // Funktion zum Aktualisieren einer bestehenden Industrie
    public function updateIndustry($industry_id)
    {
        if (! $this->validate('industry')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true);
        }

        $data = [
            'sector_id'  => $this->request->getPost('sector_id'),
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->industryModel->updateIndustry($industry_id, $data);
            return redirect()
                ->to('/config/industry')
                ->with('success', 'Industrie erfolgreich aktualisiert.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true)
                ->with('error', 'Industrie update fehlgeschlagen');
        }
    }

    // Funktion zum Löschen einer Industrie
    public function deleteIndustry($industry_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->industryModel->deleteIndustry($industry_id);

            return redirect()
                ->to('/config/industry')
                ->with('success', 'Industrie erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/industry')
                ->with('error', $exception->getMessage());
        }
    }
}