<?php

namespace App\Controllers;

use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;

class ConfigController extends BaseController
{

    private function loadConfigData(){
        $industryModel = new IndustryModel();
        $sectorModel = new SectorModel();
        $standardModel = new StandardModel();
        $requirementModel = new RequirementModel();

        return [
            'industries' => $industryModel->getIndustries(),
            'sectors' => $sectorModel->getSectors(),
            'standards' => $standardModel->getStandards(),
            'requirements' => $requirementModel->getRequirements(),
        ];
    }

    public function general()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_general');
        echo view('templates/footer');
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

    public function industry()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_industry', $data);
        echo view('templates/footer');
    }

    public function standard()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_standard', $data);
        echo view('templates/footer');
    }

    public function requirement()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_requirement', $data);
        echo view('templates/footer');
    }


}
