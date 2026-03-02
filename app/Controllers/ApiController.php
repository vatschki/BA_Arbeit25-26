<?php

namespace App\Controllers;

use App\Models\CompanyModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\ReportModel;
use App\Models\ReportValueModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use App\Models\JobModel;
use CodeIgniter\RESTful\ResourceController;

class ApiController extends ResourceController{

    protected CompanyModel $companyModel;
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;

    protected StandardModel $standardModel;
    protected ReportModel $reportModel;
    protected RequirementModel $requirementModel;
    protected JobModel $jobModel;
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
        $this->jobModel = new JobModel();
        $this->reportValueModel = new ReportValueModel();
    }

    public function saveapikey()
    {
        $provider = $this->request->getPost('provider_name');
        $model = $this->request->getPost('model_name');
        $apikey = $this->request->getPost('api_key');

        if (!$provider || !$model || !$apikey) {
            return redirect()->back()->with('error', 'Alle Felder sind erforderlich.')->withInput();
        }

        if (!str_starts_with($model, 'models/')) {
            $model = 'models/' . $model;
        }

        session()->set('api_config', [
            'provider_name' => $provider,
            'model_name' => $model,
            'api_key' => $apikey
        ]);

        $result = $this->apikeytest();

        if ($result === true) {
            return redirect()->back()->with('success', 'API-Schlüssel erfolgreich gespeichert und getestet.');
        }

        session()->remove('api_config');

        return redirect()->back()
            ->with('error', 'API-Test fehlgeschlagen: ' . $result);
    }

    public function apikeytest()
    {
        $api_config = session()->get('api_config');

        if (!$api_config) {
            return 'API-Konfiguration nicht gefunden in der Session.';
        }

        $provider = $api_config['provider_name'];
        $model = $api_config['model_name'];
        $apikey = $api_config['api_key'];

        try {

            if ($provider !== 'gemini') {
                return 'Unbekannter Provider.';
            }

            $client = \Config\Services::curlrequest([
                'timeout' => 10,
            ]);

            $url = 'https://generativelanguage.googleapis.com/v1beta/'
                . $model
                . ':generateContent?key='
                . $apikey;

            $response = $client->post($url, [
                'headers' => [
                    'Content-Type' => 'application/json',
                ],
                'json' => [
                    'contents' => [
                        [
                            'parts' => [
                                ['text' => 'ping']
                            ]
                        ]
                    ]
                ]
            ]);

            $statusCode = $response->getStatusCode();

            if ($statusCode !== 200) {
                return 'Unerwarteter HTTP-Status: ' . $statusCode;
            }

            $body = json_decode($response->getBody(), true);

            if (!isset($body['candidates'][0]['content'])) {
                return 'Antwort erhalten, aber kein gültiger Inhalt.';
            }

            return true;

        } catch (\Throwable $e) {
            return 'API-Fehler: ' . $e->getMessage();
        }
    }


    public function process()
    {
        log_message('error', 'PROCESS START');

        $report_id  = null;
        $jobCreated = false;
        $absolutePath = null;

        try {

            // -------- Request --------
            $request = $this->request;
            log_message('info', 'REQUEST OK');

            //-------- Formdaten --------
            $company_id = $request->getPost('company_id');
            $author_id = (int) $request->getPost('author_id');
            $year = $request->getPost('year');
            $standard_id = $request->getPost('standard_id');
            $requirement_id = $request->getPost('requirement_id');
            $relevant_pages = $request->getPost('relevant_pages');

            if (! $company_id || ! $author_id || ! $year || ! $standard_id) {
                throw new \RuntimeException('Pflichtfelder ausfüllen.');
            }

            log_message('info', 'FORM DATA OK');

            //-------- Company --------
            $company = $this->companyModel->getCompanyNameById($company_id);

            if (!$company || empty($company['name'])) {
                throw new \RuntimeException('Ungültige Firma ausgewählt.');
            }

            log_message('info', 'COMPANY OK');

            //-------- PDF File --------
            $pdf = $request->getFile('report');
            log_message('info', 'FILE OBJECT: ' . print_r($pdf, true));

            if (!$pdf || !$pdf->isValid()) {
                throw new \RuntimeException('Kein gültiges PDF vorhanden');
            }
            log_message('info', 'FILE VALID');

            $uploadPath = realpath(FCPATH . '../storage/uploads') . DIRECTORY_SEPARATOR;
            log_message('info', 'UPLOAD PATH: ' . $uploadPath);

            if (!is_dir($uploadPath)) {
                throw new \RuntimeException('Upload-Verzeichnis existiert nicht.');
            }
            log_message('info', 'UPLOAD DIR OK');

            $randomName = $pdf->getRandomName();
            $cleanCompany = preg_replace('/[^a-zA-Z0-9_-]/', '_', $company['name']);
            $cleanYear    = preg_replace('/[^0-9]/', '', $year);

            $newName = $cleanCompany . '_' . $cleanYear . '_' . $randomName;

            log_message('info', 'NEW NAME: ' . $newName);

            $pdf->move($uploadPath, $newName);
            log_message('info', 'FILE MOVED');

            $absolutePath = $uploadPath . $newName;
            log_message('info', 'ABSOLUTE PATH: ' . $absolutePath);

            //-------- Standards --------
            $main_standard = $this->standardModel->getStandardById($standard_id);

            $second_standard = $this->standardModel->getStandardById($standard_id + 1);  #das ist temporär nur funktional - DB pointer via ID auf nächsten standard muss in Zukunft geändert werden

            if (!$main_standard || empty($main_standard['code'])) {
                throw new \RuntimeException('Ungültige Standard-ID');
            }

            log_message('info', 'STANDARDS OK');

            //-------- Relevant Pages --------
            $useRelevantPages = $request->getPost('relevantPagesCheck') === '1';// Checkbox

            if ($useRelevantPages) {

                if (empty($relevant_pages) || !is_array($relevant_pages)) {
                    throw new \RuntimeException('Bitte relevante Seiten angeben.');
                }

                $cleanPages = [];

                foreach ($relevant_pages as $pair) {
                    $start = (int)($pair['start'] ?? 0);
                    $end   = (int)($pair['end'] ?? 0);

                    if ($start > 0 && $end > 0 && $start <= $end) {
                        for ($i = $start; $i <= $end; $i++) {
                            $cleanPages[] = $i;
                        }
                    }
                }

                if (count($cleanPages) === 0) {
                    throw new \RuntimeException('Mindestens ein gültiger Seitenbereich erforderlich.');
                }

                $relevant_pages = $cleanPages;

            } else {
                $relevant_pages = null;
            }

            //-------- Context --------
            $context_payload = [
                'company_name' => $company['name'],
                'year' => $year,
                'main_standard_code' => $main_standard['code'],
                'main_standard_name' => $main_standard['name'],
                'main_standard_description' => $main_standard['description'],
                'main_standard_description_eng' => $main_standard['description_eng'],
                'second_standard_code' => $second_standard['code'] ?? null,
                'second_standard_name' => $second_standard['name'] ?? null,
                'second_standard_description' => $second_standard['description'] ?? null,
                'second_standard_description_eng' => $second_standard['description_eng'] ?? null,
                'relevant_pages' => $relevant_pages,
            ];

            log_message('info', 'CONTEXT OK');

            //-------- Requirements --------

            if ($requirement_id === null || $requirement_id === '') {
                throw new \RuntimeException('Bitte wählen Sie eine ESRS-Anforderung aus.');
            }

            if ($requirement_id === 'ALL') {

                $requirements = $this->requirementModel->getRequirementsByStandardId((int)$standard_id);

            } else {

                $singleRequirement = $this->requirementModel->getRequirementByIdAndStandard((int)$requirement_id, (int)$standard_id);

                if ($singleRequirement === null) {
                    throw new \RuntimeException('Ungültige ESRS-Anforderung');
                }

                $requirements = [$singleRequirement];
            }

            if (empty($requirements)) {
                throw new \RuntimeException('Keine ESRS-Anforderungen gefunden');
            }


            $requirementPayload = array_map(
                static function (array $requirement): array {
                    return [
                        'id'        => $requirement['id'],
                        'code'      => $requirement['code'],
                        'title'     => $requirement['title'],
                        'data_type' => $requirement['data_type'],
                    ];
                },
                $requirements
            );

            log_message('info', 'REQUIREMENTS OK');

            //-------- API Config --------
            $api_config = session()->get('api_config');

            if (
                empty($api_config) ||
                !is_array($api_config) ||
                empty($api_config['provider_name']) ||
                empty($api_config['model_name']) ||
                empty($api_config['api_key'])
            ) {
                session()->setFlashdata(
                    'error',
                    'Bitte konfigurieren Sie zuerst Ihren API-Provider und API-Key.'
                );

                return redirect()->to('/config/api-key');
            }

            log_message('info', 'API CONFIG OK');

            //-------- Report --------
            $reportData = [
                'company_id'      => $company_id,
                'author_id'       => $author_id,
                'reporting_year'  => $year,
                'description'     => null,
                'status' => 'draft',
            ];

            $report_id = $this->reportModel->createReport($reportData);

            log_message('info', 'REPORT CREATED: ' . $report_id);

            //-------- Payload --------
            $payload = [
                'document' => [
                    'path'     => $absolutePath,
                    'filename' => $newName,
                    'type'     => 'pdf',
                ],

                'report_id' => $report_id,

                'requirement' => $requirementPayload,

                'context' => $context_payload,

                'api_config' => $api_config,
            ];

            log_message('info', 'PAYLOAD READY');

            // -------- JOB DIRECTORY --------
            $job_id   = bin2hex(random_bytes(16));

            $jobsRoot = realpath(FCPATH . '../storage/jobs');

            if (!$jobsRoot) {
                throw new \RuntimeException('Jobs-Verzeichnis existiert nicht.');
            }

            $jobDir = $jobsRoot . DIRECTORY_SEPARATOR . $job_id;

            if (!mkdir($jobDir, 0775, true)) {
                throw new \RuntimeException('Job-Verzeichnis konnte nicht erstellt werden.');
            }

            file_put_contents(
                $jobDir . '/request.json',
                json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT)
            );

            file_put_contents(
                $jobDir . '/status.json',
                json_encode([
                    'job_id' => $job_id,
                    'step'   => 'queued',
                    'percent'=> 0,
                    'message'=> 'Job gestartet'
                ])
            );

            // -------- Python-Job starten --------
            $python = '/Applications/MAMP/htdocs/BA_WebApp/backend/.venv/bin/python';
            $script = realpath(FCPATH . '../backend/run_job.py');

            $cmd = sprintf(
                'nohup %s %s --job-id %s --jobs-root %s > %s 2>&1 < /dev/null &',
                escapeshellcmd($python),
                escapeshellarg($script),
                escapeshellarg($job_id),
                escapeshellarg($jobsRoot),
                escapeshellarg($jobDir . '/stdout.log')
            );

            exec($cmd);

            // -------- Job anlegen --------
            $this->jobModel->createJob([
                'job_id'     => $job_id,
                'report_id'  => $report_id,
                'user_id'    => session()->get('user')['id'],
                'standard_id'=> (int) $standard_id,
                'status'     => 'running',
            ]);

            return redirect()->to("/esg-reports/value/{$report_id}");

        } catch (\Throwable $e) {

            if ($report_id !== null && !$jobCreated) {
                $this->reportModel->delete($report_id);
            }

            if ($absolutePath && file_exists($absolutePath)) {
                unlink($absolutePath);
            }

            return redirect()
                ->back()
                ->withInput()
                ->with('error', $e->getMessage());
        }
    }

    public function pipelinestatus(string $job_id)
    {
        $jobsRoot   = realpath(FCPATH . '../storage/jobs') . DIRECTORY_SEPARATOR;
        $jobDir     = $jobsRoot . $job_id . DIRECTORY_SEPARATOR;
        $statusPath = $jobDir . 'status.json';

        if (!is_file($statusPath)) {
            return $this->respond([
                'job_id' => $job_id,
                'step' => 'starting',
                'percent' => 0,
                'message' => 'Pipeline wird initialisiert'
            ], 200);
        }

        $raw = file_get_contents($statusPath);
        $data = json_decode($raw, true);

        if (!is_array($data)) {
            return $this->respond([
                'job_id' => $job_id,
                'step' => 'error',
                'percent' => 100,
                'message' => 'status.json ungültig'
            ], 200);
        }

        $step = $data['step'] ?? null;

        $job = $this->jobModel->findByjob_id($job_id);
        log_message('error', "PIPESTATUS job_id={$job_id}");
        log_message('error', "PIPESTATUS step=" . ($step ?? 'NULL'));
        log_message('error', "PIPESTATUS db_job_status=" . ($job['status'] ?? 'NULL'));

        if (!$job) {
            return $this->respond($data, 200);
        }

        // -----------------------------
        // TERMINAL STATES
        // -----------------------------
        $terminalStates = ['finished', 'error', 'no_match', 'not_compatible'];

        if (in_array($step, $terminalStates, true)) {

            log_message('error', 'PIPESTATUS terminal_state_detected');
            log_message('error', 'PIPESTATUS will_finalize=' . (($job['status'] === 'running') ? 'yes' : 'no'));

            if ($job['status'] === 'running') {

                // Status sofort setzen (Lock-Effekt)
                $this->jobModel->updateStatus($job_id, $step);

                if ($step === 'finished') {

                    $resultPath = $jobDir . 'final_result.json';

                    log_message('error', 'PIPESTATUS result_path=' . $resultPath);
                    log_message('error', 'PIPESTATUS result_exists=' . (is_file($resultPath) ? 'yes' : 'no'));

                    if (is_file($resultPath)) {

                        $resultRaw = file_get_contents($resultPath);
                        $result = json_decode($resultRaw, true);

                        log_message('error', 'PIPESTATUS result_json_valid=' . (is_array($result) ? 'yes' : 'no'));
                        log_message('error', 'PIPESTATUS result_has_results=' . (isset($result['results']) ? 'yes' : 'no'));

                        if (is_array($result) && isset($result['results'])) {

                            $this->reportValueModel->persistFromPipelineResult(
                                internaljobid: $job['id'],
                                report_id: $job['report_id'],
                                standard_id: $job['standard_id'],
                                result: $result['results']
                            );

                            $this->reportModel->update(
                                $job['report_id'],
                                ['status' => 'ready']
                            );
                        }
                    }
                }

                if ($step === 'error') {
                    $this->reportModel->update(
                        $job['report_id'],
                        ['status' => 'failed']
                    );
                }

                if ($step === 'not_compatible') {
                    $this->reportModel->update(
                        $job['report_id'],
                        ['status' => 'not_compatible']
                    );
                }

                if ($step === 'no_match') {
                    $this->reportModel->update(
                        $job['report_id'],
                        ['status' => 'ready']
                    );
                }
            }
        }

        return $this->respond($data, 200);
    }
}
