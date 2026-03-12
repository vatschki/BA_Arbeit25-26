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
use App\Models\JobModel;

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
    protected JobModel $jobModel;

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
        $this->jobModel = new JobModel();
    }

    // Zeigt die Werte eines ESG-Berichts an
    public function index(int $report_id)
    {
        $pipelineJob = session()->get('pipeline_job');

        $job = $this->jobModel->findByReportId($report_id);

        if ($job && in_array($job['status'], ['error', 'no_match'], true)) {

            $msg = $job['status'] === 'no_match'
                ? 'In dem Dokument konnten keine passenden Textstellen gefunden werden.'
                : 'Die Analyse ist fehlgeschlagen.';

            // Job optional löschen
            $this->jobModel->delete($job['id']);

            return redirect()
                ->to('/esg-reports')
                ->with('error', $msg);
        }


        $job = $this->jobModel->findRunningByReportId($report_id);

        $pipelineActive = false;
        $job_id = null;

        if ($job) {
            $pipelineActive = true;
            $job_id = $job['job_id'];
        }

        $report = $this->reportModel->getReportById($report_id);

        if (!$report) {
            throw new \RuntimeException('Report nicht gefunden');
        }

        $company = $this->companyModel->getCompanyNameById($report['company_id']);



        $data = [
            'report' => $report,
            'company' => $company,
            'standards' => $this->standardModel->getStandards(),
            'requirements' => $this->requirementModel->getRequirements(),
            'report_values' => $this->reportValueModel->getReportValues($report_id),

            'pipelineActive' => $pipelineActive,
            'job_id'          => $job_id,
            'currentReportId'=> $report_id,
        ];

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_EsgReportValues', $data);
        echo view('templates/footer');
    }

    public function valuesPartial(int $report_id)
    {
        return view('pages/partials/report_values_table', [
            'report_values' => $this->reportValueModel->getReportValues($report_id),
        ]);
    }

}
