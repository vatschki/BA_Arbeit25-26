<?php

namespace App\Controllers;

use App\Models\CompanyModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\ReportModel;
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
        try {

            $request = $this->request;

            $pdf = $request->getFile('report');

            if (!$pdf || !$pdf->isValid()) {
                return $this->fail('Kein gültiges PDF vorhanden');
            }

            $uploadPath = realpath(FCPATH . '../storage/uploads') . DIRECTORY_SEPARATOR;

            if (!is_dir($uploadPath)) {
                return $this->failServerError('Upload-Verzeichnis existiert nicht.');
            }

            $newName = $pdf->getRandomName();
            $pdf->move($uploadPath, $newName);

            $absolutePath = $uploadPath . $newName;

            $company_id = $request->getPost('company_id');
            $year = $request->getPost('year');
            $standard_id = $request->getPost('standard_id');
            $requirement_id = $request->getPost('requirement_id');

            $company = $this->companyModel->getCompanyNameById($company_id);


            if (!$company || empty($company['name'])) {
                return $this->fail('Ungültige Firmen-ID');
            }

            $company_name = $company['name'];

            $main_standard = $this->standardModel->getStandardById($standard_id);
            #das ist temporär nur funktional - DB pointer via ID auf nächsten standard muss in Zukunft geändert werden
            $second_standard = $this->standardModel->getStandardById($standard_id + 1);

            if (!$main_standard || empty($main_standard['code'])) {
                return $this->fail('Ungültige Standard-ID');
            }

            $main_standard_code = $main_standard['code'];
            $main_standard_name = $main_standard['name'];
            $main_standard_description = $main_standard['description'];
            $main_standard_description_eng = $main_standard['description_eng'];
            $second_standard_code = $second_standard['code'];
            $second_standard_name = $second_standard['name'];
            $second_standard_description = $second_standard['description'];
            $second_standard_description_eng = $second_standard['description_eng'];

            $context_payload = [
                'company_name' => $company_name,
                'year' => $year,
                'main_standard_code' => $main_standard_code,
                'main_standard_name' => $main_standard_name,
                'main_standard_description' => $main_standard_description,
                'main_standard_description_eng' => $main_standard_description_eng,
                'second_standard_code' => $second_standard_code,
                'second_standard_name' => $second_standard_name,
                'second_standard_description' => $second_standard_description,
                'second_standard_description_eng' => $second_standard_description_eng,
            ];


            if ($requirement_id === 'ALL') {

                $requirements = $this->requirementModel
                    ->getRequirementsByStandardId((int)$standard_id);

            } else {

                $singleRequirement = $this->requirementModel
                    ->getRequirementByIdAndStandard((int)$requirement_id, (int)$standard_id);

                if ($singleRequirement === null) {
                    return $this->fail('Ungültige ESRS-Anforderung');
                }

                $requirements = [$singleRequirement];
            }

            if (empty($requirements)) {
                return $this->fail('Keine ESRS-Anforderungen gefunden');
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

            // Wichtig: author_id ist NOT NULL in deiner DB.
            $author_id = (int) (session()->get('user_id') ?? 1); // DUMMY: 1

            // 4) Report SOFORT anlegen -> wir brauchen report_id für Redirect
            $reportData = [
                'company_id'      => $company_id,
                'author_id'       => $author_id,
                'reporting_year'  => $year,
                'description'     => null,
                'metadata'        => json_encode([
                    'source_pdf' => $newName,
                    'standard_id' => $standard_id,
                    'requirement_id' => $requirement_id,
                ]),
            ];

            $report_id = $this->reportModel->createReport($reportData);

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

            $client = \Config\Services::curlrequest();
            $res = $client->post('http://localhost:8001/pipeline/start', [
                'json' => $payload,
                'headers' => [
                    'Accept' => 'application/json',
                    'Content-Type' => 'application/json'
                ],
                'timeout' => 0,
                'http_errors' => false,
            ]);

            $statusCode = $res->getStatusCode();
            $body       = $res->getBody();

            log_message('error', 'PIPELINE STATUS: ' . $statusCode);
            log_message('error', 'PIPELINE BODY: ' . $body);

            #report dann löschen damit kein trash entsteht
            if ($statusCode !== 200) {
                log_message('error', 'Pipeline start failed: ' . $body);

                session()->setFlashdata(
                    'error',
                    'Die Analyse konnte nicht gestartet werden. Bitte versuchen Sie es erneut.'
                );

                return redirect()->back();
            }


            $data = json_decode($res->getBody(), true);

            /*
            return $this->respond([
                'status'  => 'success',
                'job_id'  => $data['job_id'],
                'message' => $data['message'],
                //'result'  => $data['result']
            ]);
            */

            $job_id = $data['job_id'] ?? null;

            if (!$job_id) {
                log_message('error', 'Pipeline start ohne job_id: ' . $body);

                return $this->respond([
                    'status' => 'error',
                    'message' => 'Pipeline konnte nicht gestartet werden (keine Job-ID)'
                ], 500);
            }


            $jobData = [
                'job_id'        => $job_id,
                'report_id'       => $report_id,
                'standard_id'     => (int) $standard_id,
                'requirements_all'=> $requirement_id === 'ALL' ? 1 : 0,
                'status'          => 'running',
                'created_at'      => date('Y-m-d H:i:s'),
            ];

            $this->jobModel->createJob($jobData);


            return redirect()->to("/esg-reports/value/{$report_id}");

        }catch (\Throwable $e){
            return $this->failServerError($e->getMessage());
        }
    }

    public function pipelinestatus(string $job_id)
    {
        try {
            $client = \Config\Services::curlrequest([
                'timeout' => 3,
            ]);

            $response = $client->get(
                "http://localhost:8001/pipeline/status/{$job_id}"

            );

            return $this->respond(
                json_decode($response->getBody(), true),
                $response->getStatusCode()
            );

        } catch (\Throwable $e) {
            return $this->respond([
                'percent' => 0,
                'message' => 'Pipeline nicht erreichbar'
            ], 502);
        }
    }
}
