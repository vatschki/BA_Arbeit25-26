<?php

namespace App\Controllers;

class WhatItIsController extends BaseController
{
    public function index()
    {
        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Companies');
        echo view('templates/footer');
    }
}
