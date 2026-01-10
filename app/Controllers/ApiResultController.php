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

        $job = $this->jobModel->findByjob_id($data['job_id']);
        if (! $job) {
            return $this->failNotFound('Job not found');
        }

        if (in_array($job['status'], ['finished', 'error'], true)) {
            return $this->respond(['ok' => true]);
        }

        $status = $data['status'];

        if ($job['status'] === 'finished') {
            return $this->respond(['ok' => true]);
        }

        try {

            // Fehlerfall
            if ($status === 'error') {
                $this->jobModel->updateStatus($job['job_id'], 'error');
                return $this->respond(['ok' => true]);
            }

            // Erfolgfall
            if ($status === 'finished') {

                if (!isset($data['result']) || !is_array($data['result'])) {
                    return $this->failValidationErrors('Missing result for finished job');
                }

                // 1) Job auf finished setzen
                $this->jobModel->updateStatus($job['job_id'], 'finished');

                // 2) Werte persistieren
                $this->reportValueModel->persistFromPipelineResult(
                    internaljobid: $job['id'],
                    report_id: $job['report_id'],
                    standard_id: $job['standard_id'],
                    result: $data['result']
                );

                return $this->respond(['ok' => true]);
            }

            // Unbekannter Status
            return $this->failValidationErrors('Unknown job status');

        } catch (\Throwable $e) {
            return $this->failServerError($e->getMessage());
        }
    }
}
