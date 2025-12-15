<?php

namespace App\Controllers;

class ConfigController extends BaseController
{
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


    public function standard()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_standard');
        echo view('templates/footer');
    }

    public function requirement()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_requirement');
        echo view('templates/footer');
    }


}
