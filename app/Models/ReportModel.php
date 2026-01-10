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
                reports.id AS report_id,
                reports.reporting_year,
        
                companies.id AS company_id,
                companies.name AS company_name,
                companies.country_id,
                companies.industry_id,
        
                industries.sector_id,
        
                authors.id AS author_id,
                authors.name AS author_name
            ")
            ->join('companies', 'reports.company_id = companies.id', 'left')
            ->join('industries', 'companies.industry_id = industries.id', 'left')
            ->join('authors', 'reports.author_id = authors.id', 'left')
            ->findAll();
    }

    public function getReportById(int $report_id): array
    {
        return $this->select('reporting_year')
            ->where('id', $report_id)
            ->first();
    }

    public function getByCompanyId(int $company_id): array
    {
        return $this->db->table('reports')
            ->select('
            reports.id AS report_id,
            reports.reporting_year,
            reports.company_id,
            reports.author_id,
            companies.name AS company_name,
            authors.name AS author_name
        ')
            ->join(
                'companies',
                'companies.id = reports.company_id',
                'left'
            )
            ->join(
                'authors',
                'authors.id = reports.author_id',
                'left'
            )
            ->where('reports.company_id', $company_id)
            ->orderBy('reports.reporting_year', 'DESC')
            ->get()
            ->getResultArray();
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
