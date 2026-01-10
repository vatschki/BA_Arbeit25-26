<?php

namespace App\Controllers;

use App\Models\ReportModel;
use App\Models\RequirementModel;
use App\Models\StandardModel;
use App\Models\JobModel;
use App\Models\ReportValueModel;
use CodeIgniter\RESTful\ResourceController;

class ApiResultController extends ResourceController{
    protected StandardModel $standardModel;
    protected ReportModel $reportModel;
    protected RequirementModel $requirementModel;
    protected JobModel $jobModel;
    protected ReportValueModel $reportValueModel;

    public function __construct()
    {
        $this->standardModel = new StandardModel();
        $this->reportModel = new ReportModel();
        $this->requirementModel = new RequirementModel();
        $this->jobModel = new JobModel();
        $this->reportValueModel = new ReportValueModel();
    }

    public function store()
    {

        if ($this->request->getHeaderLine('Authorization') !== 'Bearer ' . getenv('PIPELINE_SECRET')) {
            return $this->failUnauthorized();
        }

        $data = $this->request->getJSON(true);

        if (empty($data['job_id']) || !isset($data['result'])) {
            return $this->failValidationErrors();
        }

        $job = $this->jobModel->findByjob_id((int) $data['job_id']);
        if (! $job) {
            return $this->failNotFound('Job not found');
        }

        if ($job['status'] === 'finished') {
            return $this->respond(['ok' => true]);
        }

        try {
            // 1) Job aktualisieren
            $this->jobModel->updateStatus($job['job_id'], 'finished');

            $internaljobid = $job['id'];
            $report_id = $job['report_id'];
            $standard_id = $job['standard_id'];

            // 2) Values befüllen (unabhängig)
            $this->reportValueModel->persistFromPipelineResult(
                internaljobid: $internaljobid,
                report_id: $report_id,
                standard_id: $standard_id,
                result: $data['result']
            );
        } catch (\Throwable $e) {
            return $this->failServerError($e->getMessage());
        }

        return $this->respond(['ok' => true]);
    }


}
