<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class ReportModel extends BaseModel{

    protected $table = 'reports';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'company_id',
        'author_id',
        'reporting_year',
        'description',
    ];

    protected $validationRules = [
        'company_id' => 'required|integer',
        'author_id' => 'required|integer',
        'reporting_year' => 'required|integer',
        'description' => 'permit_empty|max_length[500]'
    ];

    public function getReports(): array
    {
        return $this->select("
            reports.*,
            reports.id    AS report_id,
            companies.id   AS company_id,
            companies.name AS company_name,
            authors.id    AS author_id,
            authors.name AS author_name"
        )
            ->join("companies", "reports.company_id = companies.id", "left")
            ->join("authors", "reports.author_id = authors.id", "left")
            ->findAll();
    }

    public function getByCompanyId(int $company_id){
        return $this->where("company_id", $company_id)
            ->orderBy("reporting_year", "DESC")
            ->findAll();
    }

    public function createReport(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new \RuntimeException(
                'Validation of Report failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }
}
