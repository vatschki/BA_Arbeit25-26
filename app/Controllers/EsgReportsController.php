<?php

namespace App\Controllers;

use App\Models\AuditorModel;
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
    protected AuditorModel $auditorModel;

    public function __construct()
    {
        $this->companyModel = new CompanyModel();
        $this->standardModel = new StandardModel();
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->reportModel = new ReportModel();
        $this->sectorModel = new SectorModel();
        $this->requirementModel = new RequirementModel();
        $this->auditorModel = new AuditorModel();
    }

    // Zeigt die Liste der ESG-Berichte an
    public function index()
    {
        $reports = $this->reportModel->getReports();

        $years = array_unique(array_column($reports, 'reporting_year'));
        rsort($years);

        $data = [
            'companies'    => $this->companyModel->getCompanies(),
            'countries'    => $this->countryModel->getCountries(),
            'sectors'      => $this->sectorModel->getSectors(),
            'industries'   => $this->industryModel->getIndustriesWithSectors(),
            'reports'      => $reports,
            'years'        => $years,
            'standards'    => $this->standardModel->getStandards(),
            'requirements' => $this->requirementModel->getRequirements(),
            'auditors'      => $this->auditorModel->getAuditors(),
        ];

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_EsgReports', $data);
        echo view('templates/footer');
    }

    // Zeigt die ESG-Berichte eines bestimmten Unternehmens an
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

    // Funktion zum Löschen eines ESG-Berichts
    public function deleteReport($report_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->reportModel->deleteReport($report_id);

            return redirect()
                ->to('/esg-reports/')
                ->with('success', 'Report erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/esg-reports/')
                ->with('error', $exception->getMessage());
        }
    }


}