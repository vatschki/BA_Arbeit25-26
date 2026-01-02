<?php

namespace App\Controllers;

use App\Models\CompanyModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\ReportModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use CodeIgniter\RESTful\ResourceController;

class ApiController extends ResourceController{

    protected CompanyModel $companyModel;
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;

    protected StandardModel $standardModel;
    protected ReportModel $reportModel;
    protected RequirementModel $requirementModel;

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
        $api_config = session()->get('api_config');

        if (empty($api_config)) {
            return redirect()->back()->with('error', 'API-Konfiguration fehlt.');
        }

        $company_id     = $this->request->getPost('company_id');
        $year           = $this->request->getPost('year');
        $standard_id    = $this->request->getPost('standard_id');
        $requirement_id = $this->request->getPost('requirement_id');

        $company  = $this->companyModel->find($company_id);
        $standard = $this->standardModel->find($standard_id);

        if ($requirement_id === 'ALL') {
            //Alle
            $requirements = $this->requirementModel
                ->where('standard_id', $standard_id)
                ->findAll();

        } else {
            //Ein bestimmtes
            $requirement = $this->requirementModel
                ->where('id', $requirement_id)
                ->where('standard_id', $standard_id)
                ->first();

            if (!$requirement) {
                throw new \RuntimeException('Ungültige ESRS-Anforderung');
            }

            $requirements = [$requirement];
        }


        // Placeholder for future implementation
        return $this->respond(['message' => 'Process endpoint is under construction.'], 200);
    }
}
