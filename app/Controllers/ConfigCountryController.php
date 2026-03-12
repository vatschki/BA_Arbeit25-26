<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use RuntimeException;

class ConfigCountryController extends BaseController
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
    // Country Methods
    //--------------------

    // Zeigt die Liste der Länder an
    public function country()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_country', $data);
        echo view('templates/footer');
    }

    // Funktion zum Anlegen eines neuen Landes
    public function createCountry()
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('message', 'Keine Berechtigung.');
        }

        if (! $this->validate('country')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openStandardModal', true);
        }

        $data = [
            'code'       => $this->request->getPost('code'),
            'name_de'        => $this->request->getPost('name_de'),
            'name_eng' => $this->request->getPost('name_eng'),
            'region' => $this->request->getPost('region'),
            'eu_member'  => (int) $this->request->getPost('eu_member'),
        ];

        try {
            $this->countryModel->createCountry($data);

            return redirect()
                ->to('/config/country')
                ->with('success', 'Land erfolgreich angelegt.');
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openCountryModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    // Funktion zum Aktualisieren eines Landes
    public function updateCountry($country_id)
    {
        if (! $this->validate('country')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openCountryModal', true);
        }

        $data = [
            'code'       => $this->request->getPost('code'),
            'name_de'        => $this->request->getPost('name_de'),
            'name_eng' => $this->request->getPost('name_eng'),
            'region' => $this->request->getPost('region'),
            'eu_member'  => (int) $this->request->getPost('eu_member'),
        ];

        try {
            $this->countryModel->updateCountry($country_id, $data);

            return redirect()
                ->to('/config/country')
                ->with('success', 'Land erfolgreich aktualisiert.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openCountryModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    // Funktion zum Löschen eines Landes
    public function deleteCountry($country_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->countryModel->deleteCountry($country_id);

            return redirect()
                ->to('/config/country')
                ->with('success', 'Land erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/country')
                ->with('error', $exception->getMessage());
        }
    }

}