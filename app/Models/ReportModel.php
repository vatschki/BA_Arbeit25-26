<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class ReportModel extends BaseModel{

    protected $table = 'reports';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'company_id',
        'reporting_year',
        'description',
        'status',
    ];

    protected $validationRules = [
        'company_id' => 'required|integer',
        'reporting_year' => 'required|integer',
        'description' => 'permit_empty|max_length[500]',
        'status' => 'required|in_list[draft,failed, not_compatible, ready, archived]',
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

            GROUP_CONCAT(DISTINCT auditors.name ORDER BY auditors.name SEPARATOR ', ') AS auditor_name
        ")
            ->join('companies', 'reports.company_id = companies.id', 'left')
            ->join('industries', 'companies.industry_id = industries.id', 'left')

            ->join('audit_report', 'audit_report.report_id = reports.id', 'left')
            ->join('auditors', 'auditors.id = audit_report.auditor_id', 'left')

            ->where('reports.status', 'ready')

            ->groupBy('reports.id')

            ->orderBy('companies.name', 'ASC')
            ->findAll();
    }

    public function getReportById(int $report_id): array
    {
        return $this->select('reports.*')
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
            reports.auditor_id,
            companies.name AS company_name,
            auditors.name AS auditor_name
        ')
            ->join(
                'companies',
                'companies.id = reports.company_id',
                'left'
            )
            ->join(
                'auditors',
                'auditors.id = reports.auditor_id',
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


    public function hasReportsForCompany(int $companyId): bool
    {
        return $this->where('company_id', $companyId)
                ->countAllResults(false) > 0;
    }

    public function deleteReport(int $report_id): bool
    {
        $report = $this->find($report_id);

        if (! $report) {
            throw new RuntimeException('Report nicht gefunden.');
        }

        // Prüfen ob noch Values existieren (FK-Schutz)
        $hasValues = $this->db->table('esrs_reportvalue')
            ->where('report_id', $report_id)
            ->countAllResults();

        if ($hasValues > 0) {
            throw new RuntimeException('Report kann nicht gelöscht werden, da noch Werte existieren.');
        }

        return (bool) parent::delete($report_id);
    }

}
