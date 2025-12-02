<?php

namespace App\Controllers;

class CompaniesController extends BaseController
{
    public function index()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Companies');
        echo view('templates/footer');
    }

    public function testDb()
    {
        $db = \Config\Database::connect();
        $query = $db->query("SHOW TABLES");
        $result = $query->getResult();

        return print_r($result);
    }

}
