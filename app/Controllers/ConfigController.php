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

    //--------------------
    // API Key Methods
    //--------------------
    public function apikey()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_api-key');
        echo view('templates/footer');
    }


}
