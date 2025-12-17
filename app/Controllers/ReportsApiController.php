<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class ReportsApiController extends ResourceController{

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

            $payload = [
                'pdf_path' => $absolutePath,
                'company_id' => $company_id,
                'year' => $year,
                'standard_id' => $standard_id,
                'requirement_id' => $requirement_id
            ];

            $client = \Config\Services::curlrequest();
            $res = $client->post('http://localhost:8001/pipeline/start', [
                'json' => $payload,
                'headers' => [
                    'Accept' => 'application/json',
                    'Content-Type' => 'application/json'
                ],
                'timeout' => 300
            ]);

            $data = json_decode($res->getBody(), true);

            return $this->respond([
                'status' => 'success',
                'job_id' => $data['job_id'] ?? null,
                'pipeline_status' => $data['status'] ?? null,
                'message' => 'Pipeline gestartet'
            ]);

        }catch (\Throwable $e){
            return $this->failServerError($e->getMessage());
        }
    }
}