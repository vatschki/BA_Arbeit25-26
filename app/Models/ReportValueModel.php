<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class ReportValueModel extends BaseModel{

    protected $table = 'esrs_reportvalue';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'requirement_id',
        'report_id',
        'value_text',
        'value_int',
        'unit',
        'metadata'
    ];

    protected $validationRules = [
        'requirement_id' => 'required|min_length[3]|max_length[100]',
        'report_id' => 'required|min_length[3]|max_length[100]',
    ];

    public function getReportValues($report_id): array
    {
        return $this->where("report_id", $report_id)->findAll();
    }
}

