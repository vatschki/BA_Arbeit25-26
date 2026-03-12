<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use RuntimeException;


class ConfigSectorController extends BaseController
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
    // Sector Methods
    //--------------------

    // Zeigt die Liste der Sektoren an
    public function sector()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_sector', $data);
        echo view('templates/footer');
    }

    // Funktion zum Anlegen eines neuen Sektors
    public function createSector()
    {

        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('message', 'Keine Berechtigung.');
        }

        if (! $this->validate('sector')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openSectorModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->sectorModel->createSector($data);

            return redirect()
                ->to('/config/sector')
                ->with('success', 'Sektor erfolgreich angelegt.');
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true)
                ->with('error', 'Sektor hinzufügen fehlgeschlagen');
        }
    }

    // Funktion zum Aktualisieren eines bestehenden Sektors
    public function updateSector($sector_id)
    {
        if (! $this->validate('sector')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->sectorModel->updateSector($sector_id, $data);

            return redirect()
                ->to('/config/sector')
                ->with('success', 'Sektor erfolgreich aktualisiert.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true)
                ->with('error', 'Sektor update fehlgeschlagen');
        }
    }

    // Funktion zum Löschen eines Sektors
    public function deleteSector($sector_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->sectorModel->deleteSector($sector_id);

            return redirect()
                ->to('/config/sector')
                ->with('success', 'Sektor erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/sector')
                ->with('error', $exception->getMessage());
        }
    }
}