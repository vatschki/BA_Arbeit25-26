<?php

namespace App\Controllers;

class EsgReportsController extends BaseController
{
    public function index()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_EsgReports');
        echo view('templates/footer');
    }
}