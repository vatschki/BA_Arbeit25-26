<?php

namespace App\Controllers;

use App\Models\CompanyModel;
use App\Models\ReportModel;
use App\Models\StandardModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\SectorModel;
use App\Models\RequirementModel;
//use App\Models\ReportValueModel;

class EsgReportsController extends BaseController
{
    protected CompanyModel $companyModel;
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;

    protected StandardModel $standardModel;
    protected ReportModel $reportModel;
    protected RequirementModel $requirementModel;
    //protected reportvalueModel $reportvalueModel;

    public function __construct()
    {
        $this->companyModel = new CompanyModel();
        $this->standardModel = new StandardModel();
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->reportModel = new ReportModel();
        $this->sectorModel = new SectorModel();
        $this->requirementModel = new RequirementModel();
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
            'requirements' => $this->requirementModel->getRequirements(),
        ];

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_EsgReports', $data);
        echo view('templates/footer');
    }

    public function byCompany($company_id){

        $company = $this->companyModel->find($company_id);

        if (!$company) {
            throw \CodeIgniter\Exceptions\PageNotFoundException::forPageNotFound('Company not found');
        }

        $data = [
            'company' => $this->companyModel->find($company_id),
            'reportsbycompany' => $this->reportModel->getByCompanyId($company_id),
        ];

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_EsgReports_byCompany', $data);
        echo view('templates/footer');
    }
}