<?php

namespace App\Controllers;

class EsrReportsController extends BaseController
{
    public function index()
    {
        echo view('templates/header');
        echo view('templates/menu');
        echo view('pages/page_EsrReports');
        echo view('templates/footer');
    }
}