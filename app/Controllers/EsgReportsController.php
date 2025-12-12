<?php

namespace App\Controllers;

use App\Models\CompanyModel;
use App\Models\ReportModel;
use App\Models\StandardModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\SectorModel;

class EsgReportsController extends BaseController
{
    protected CompanyModel $companyModel;
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;

    protected StandardModel $standardModel;
    protected ReportModel $reportModel;
    //protected requirementModel $requirementModel;
    //protected reportvalueModel $reportvalueModel;

    public function __construct()
    {
        $this->companyModel = new CompanyModel();
        $this->standardModel = new StandardModel();
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->reportModel = new ReportModel();
        $this->sectorModel = new SectorModel();
    }


    public function index()
    {
        $data = [
            'companies' => $this->companyModel->getCompanies(),
            'countries' => $this->countryModel->getCountries(),
            'sectors' => $this->sectorModel->getSectors(),
            'industries' => $this->industryModel->getIndustriesWithSectors(),
            'reports' => $this->reportModel->getReports(),
            'standards' => $this->standardModel->getStandards(),
        ];

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_EsgReports', $data);
        echo view('templates/footer');
    }
}