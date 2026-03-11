<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class AuditReportModel extends BaseModel{

    protected $table = 'audit_report';

    protected $allowedFields = [
        'report_id',
        'auditor_id',
        'description'
    ];

    public function insertAuditorsForReport(int $reportId, array $auditorIds): void
    {
        if (empty($auditorIds)) {
            return;
        }

        $batch = [];

        foreach ($auditorIds as $auditorId) {
            $batch[] = [
                'report_id'  => $reportId,
                'auditor_id' => (int)$auditorId
            ];
        }

        $this->insertBatch($batch);
    }
}