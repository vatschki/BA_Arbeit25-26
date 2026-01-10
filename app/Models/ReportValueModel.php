<?php

namespace App\Models;

use App\Models\BaseModel;
use App\Models\JobModel;
use App\Models\ReportModel;
use RuntimeException;

class ReportValueModel extends BaseModel{

    protected $table = 'esrs_reportvalue';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'requirement_id',
        'report_id',
        'job_id',
        'page_id',
        'page',
        'text',
    ];

    protected $validationRules = [
        'requirement_id' => 'required|integer',
        'report_id'      => 'required|integer',
        'job_id'         => 'required|integer',
        'page_id'        => 'required|string|max_length[500]',
        'page'           => 'required|integer',
        'text'           => 'required|string|max_length[1000]',
    ];

    public function getReportValues($report_id): array
    {
        return $this->select([
            'esrs_reportvalue.id AS value_id',
            'esrs_reportvalue.requirement_id',
            'esrs_reportvalue.report_id',
            'esrs_reportvalue.job_id',
            'esrs_reportvalue.page_id',
            'esrs_reportvalue.page',
            'esrs_reportvalue.text',

            // zusätzliche Felder
            'companies.name AS company_name',
            'esrs_requirements.code AS requirement_code',
        ])
            ->join(
                'esrs_requirements',
                'esrs_requirements.id = esrs_reportvalue.requirement_id',
                'left'
            )
            ->join(
                'reports',
                'reports.id = esrs_reportvalue.report_id',
                'left'
            )
            ->join(
                'companies',
                'companies.id = reports.company_id',
                'left'
            )
            ->where('esrs_reportvalue.report_id', $report_id)
            ->orderBy('esrs_reportvalue.page', 'ASC')
            ->get()
            ->getResultArray();
    }


    public function persistFromPipelineResult(int $internaljobid, int $standard_id, int $report_id, array $result): void {

        $requirements = new RequirementModel();

        foreach ($result as $entry) {

            $requirement = $requirements->getRequirementBydisclosurerequirement($entry['disclosure_requirement'], $standard_id);

            $this->insert([
                'requirement_id' => $requirement['id'],
                'report_id'      => $report_id,
                'job_id'         => $internaljobid,
                'page_id'        => $entry['page_id'],
                'page'           => $entry['page'],
                'text'           => $entry['text'],
            ]);
        }
    }

}

