<?php

namespace App\Controllers;

class CompaniesController extends BaseController
{
    public function index()
    {
        echo view('templates/header_Test');
        echo view('templates/menu_home');
        echo view('pages/page_Companies_Test');
        echo view('templates/footer');
    }
}
