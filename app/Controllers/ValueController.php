<?php

namespace App\Controllers;

use App\Models\CompanyModel;
use App\Models\ReportModel;
use App\Models\StandardModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\SectorModel;
use App\Models\RequirementModel;
use App\Models\ReportValueModel;

class ValueController extends BaseController
{
    protected CompanyModel $companyModel;
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;

    protected StandardModel $standardModel;
    protected ReportModel $reportModel;
    protected RequirementModel $requirementModel;
    protected ReportValueModel $reportValueModel;

    public function __construct()
    {
        $this->companyModel = new CompanyModel();
        $this->standardModel = new StandardModel();
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->reportModel = new ReportModel();
        $this->sectorModel = new SectorModel();
        $this->requirementModel = new RequirementModel();
        $this->reportValueModel = new ReportValueModel();
    }


    public function index($report_id)
    {
        $data = [
            'reports' => $this->reportModel->getReports(),
            'standards' => $this->standardModel->getStandards(),
            'requirements' => $this->requirementModel->getRequirements(),
            'report_values' => $this->reportValueModel->getReportValues($report_id),
        ];

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_EsgReportValues', $data);
        echo view('templates/footer');
    }
}
