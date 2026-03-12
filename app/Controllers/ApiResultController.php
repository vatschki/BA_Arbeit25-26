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

    // Endpoint für Pipeline, um Ergebnisse zu übermitteln
    public function store()
    {
        log_message('error', 'STORE HIT');
        log_message('error', 'Headers: ' . json_encode($this->request->getHeaders()));
        $raw = $this->request->getBody();
        log_message('error', 'Body: ' . $raw);

        $token = $this->request->getHeaderLine('X-PIPELINE-TOKEN');
        log_message('debug', 'Auth header: ' . $this->request->getHeaderLine('X-PIPELINE-TOKEN'));
        log_message('debug', 'Env secret: ' . var_export(getenv('PIPELINE_SECRET'), true));

        if ($token !== env('PIPELINE_SECRET')) {
            return $this->failUnauthorized();
        }

        $data = json_decode($raw, true);

        if ($data === null) {
            return $this->failValidationErrors('Invalid JSON body');
        }

        if (empty($data['job_id'])) {
            return $this->failValidationErrors('JobId missing');
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

                $this->reportModel->update($job['report_id'], ['status' => 'failed']);

                $this->deleteUploadFile();

                return $this->respond(['ok' => true]);
            }

            if ($status === 'no_match') {
                $this->jobModel->updateStatus($job['job_id'], 'no_match');
                $this->reportModel->update($job['report_id'], ['status' => 'ready']);

                $this->deleteUploadFile();

                return $this->respond(['ok' => true]);
            }

            if ($status === 'not_compatible') {
                $this->jobModel->updateStatus($job['job_id'], 'not_compatible');
                $this->reportModel->update($job['report_id'], ['status' => 'not_compatible']);

                $this->deleteUploadFile();

                return $this->respond(['ok' => true]);
            }



            // Erfolgfall
            if ($status === 'finished') {

                if (!isset($data['result']) || !is_array($data['result'])) {
                    return $this->failValidationErrors('Missing result for finished job');
                }

                //Job auf finished setzen
                $this->jobModel->updateStatus($job['job_id'], 'finished');

                //Report auf ready setzen
                $this->reportModel->update($job['report_id'], ['status' => 'ready']);

                // 2) Werte persistieren
                $this->reportValueModel->persistFromPipelineResult(
                    internaljobid: $job['id'],
                    report_id: $job['report_id'],
                    standard_id: $job['standard_id'],
                    result: $data['result']
                );

                $this->deleteUploadFile();

                return $this->respond(['ok' => true]);
            }

            // Unbekannter Status
            return $this->failValidationErrors('Unknown job status');

        } catch (\Throwable $e) {
            return $this->failServerError($e->getMessage());
        }
    }

    private function deleteUploadFile()
    {
        $uploadPath = realpath(FCPATH . '../storage/uploads') . DIRECTORY_SEPARATOR;

        foreach (glob($uploadPath . '*.pdf') as $file) {
            if (file_exists($file)) {
                unlink($file);
                log_message('info', 'FILE DELETED: ' . $file);
            }
        }
    }
}
