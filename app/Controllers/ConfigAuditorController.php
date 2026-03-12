<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\AuditorModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use RuntimeException;

class ConfigAuditorController extends BaseController
{
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;
    protected StandardModel $standardModel;
    protected RequirementModel $requirementModel;
    protected AuditorModel $auditorModel;

    public function __construct()
    {
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->sectorModel = new SectorModel();
        $this->standardModel = new StandardModel();
        $this->requirementModel = new RequirementModel();
        $this->auditorModel = new AuditorModel();
    }

    private function loadConfigData()
    {
        return [
            'industries' => $this->industryModel->getIndustries(),
            'sectors' => $this->sectorModel->getSectors(),
            'standards' => $this->standardModel->getStandards(),
            'requirements' => $this->requirementModel->getRequirements(),
            'countries' => $this->countryModel->getCountries(),
            'auditors' => $this->auditorModel->getAuditors(),
        ];
    }

    //--------------------
    // Auditor Methods
    //--------------------

    // Zeigt die Liste der Auditoren an
    public function auditor()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_auditor', $data);
        echo view('templates/footer');
    }

    // Funktion zum Anlegen eines neuen Auditors
    public function createAuditor()
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('error', 'Keine Berechtigung.');
        }

        if (! $this->validate('auditor')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openAuditorModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
            'type'        => $this->request->getPost('type'),
        ];

        try {
            $this->auditorModel->createAuditor($data);

            return redirect()
                ->to('/config/auditor')
                ->with('success', 'Eintrag erfolgreich angelegt.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openAuditorModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    // Funktion zum Aktualisieren eines Auditors
    public function updateAuditor($auditor_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('error', 'Keine Berechtigung.');
        }

        if (! $this->validate('auditor')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openAuditorModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
            'type'        => $this->request->getPost('type'),
        ];

        try {
            $this->auditorModel->updateAuditorr($auditor_id, $data);

            return redirect()
                ->to('/config/auditor')
                ->with('success', 'Eintrag erfolgreich aktualisiert.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openAuditorModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    // Funktion zum Löschen eines Auditors
    public function deleteAuditor($auditor_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->auditorModel->deleteAuditor($auditor_id);

            return redirect()
                ->to('/config/auditor')
                ->with('success', 'Eintrag erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/auditor')
                ->with('error', $exception->getMessage());
        }
    }
}