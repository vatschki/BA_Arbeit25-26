<?php

namespace App\Controllers;

use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use App\Models\CountryModel;

class ConfigController extends BaseController
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

    public function personen()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_general');
        echo view('templates/footer');
    }

    public function createPersonen(){

    }

    public function apikey()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_api-key');
        echo view('templates/footer');
    }

    public function sector()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_sector', $data);
        echo view('templates/footer');
    }

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
            'name'        => $this->request->getPost('sector_name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->sectorModel->createSector($data);
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true)
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/config/sector')
            ->with('message', 'Sektor erfolgreich angelegt.');
    }

    public function updateSector($sector_id)
    {
        if (! $this->validate('sector')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('sector_name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->sectorModel->updateSector($sector_id, $data);
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true)
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/config/sector')
            ->with('message', 'Sektor erfolgreich aktualisiert.');
    }

    public function deleteSector($sector_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->sectorModel->deleteSector($sector_id);
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/sector')
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/config/sector')
            ->with('message', 'Sektor erfolgreich gelöscht.');
    }

    public function industry()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_industry', $data);
        echo view('templates/footer');
    }

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
            'name'        => $this->request->getPost('industry_name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->industryModel->createIndustry($data);
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openIndustryModal', true)
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/config/industry')
            ->with('message', 'Industrie erfolgreich angelegt.');
    }

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
            'name'        => $this->request->getPost('industry_name'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->industryModel->updateIndustry($industry_id, $data);
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true)
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/config/indsutry')
            ->with('message', 'Sektor erfolgreich aktualisiert.');
    }

    public function deleteIndustry($industry_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->industryModel->deleteIndustry($industry_id);
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/industry')
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/config/industry')
            ->with('message', 'Sektor erfolgreich gelöscht.');
    }

    public function standard()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_standard', $data);
        echo view('templates/footer');
    }

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
            'name'        => $this->request->getPost('sector_name'),
            'description' => $this->request->getPost('description'),
            'description_eng' => $this->request->getPost('description_eng'),
        ];

        try {
            $this->standardModel->createStandard($data);
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openSectorModal', true)
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/config/sector')
            ->with('message', 'Standard erfolgreich angelegt.');
    }

    public function requirement()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_requirement', $data);
        echo view('templates/footer');
    }

    public function country()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_country', $data);
        echo view('templates/footer');
    }


}
