<?php

namespace App\Controllers;

class ConfigController extends BaseController
{
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
