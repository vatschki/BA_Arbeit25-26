<?php

namespace App\Models;

use App\Models\BaseModel;
use App\Models\ReportModel;

use RuntimeException;

class CompanyModel extends BaseModel{

    protected $table = 'companies';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'name',
        'country_id',
        'industry_id',
        'description'
    ];

    protected $validationRules = [
        'name' => 'required|min_length[3]|max_length[100]',
        'country_id' => 'required|integer',
        'industry_id' => 'required|integer',
        'description' => 'permit_empty|max_length[500]'
    ];

    public function getCompanies(): array
    {
        return $this->select("
            companies.*,
            companies.id    AS company_id,
            industries.id   AS industry_id,
            industries.name AS industry_name,
            countries.id    AS country_id,
            countries.name_de AS country_name_de,
            countries.name_eng AS country_name_eng,
            sectors.id      AS sector_id,
            sectors.name    AS sector_name"
        )
        ->join("industries", "companies.industry_id = industries.id", "left")
        ->join("countries", "companies.country_id = countries.id", "left")
        ->join("sectors", "industries.sector_id = sectors.id", "left")
        ->findAll();
    }

    public function createCompany(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new \RuntimeException(
                'Validation of Company failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }

    public function getCompanyNameById(int $company_id)
    {
        return $this->select("name")
            ->where("id", $company_id)
            ->first();
    }

    public function updateCompany(int $company_id, array $data): bool
    {
        if (! $this->update($company_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Company failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteCompany(int $company_id): bool
    {
        $company = $this->find($company_id);

        if (! $company) {
            throw new RuntimeException('Unternehmen nicht gefunden.');
        }

        $reportModel = new ReportModel();

        if ($reportModel->hasReportsForCompany($company_id)) {
            throw new RuntimeException(
                'Unternehmen kann nicht gelöscht werden, da noch Reports existieren.'
            );
        }

        return (bool) parent::delete($company_id);
    }


    public function exists(int $id): bool
    {
        return $this->where('id', $id)->countAllResults() > 0;
    }

    public function existsByNameAndCountry(string $name, int $countryId, ?int $ignoreId = null): bool
    {
        $builder = $this->where('name', $name)
            ->where('country_id', $countryId);

        if ($ignoreId !== null) {
            $builder->where('id !=', $ignoreId);
        }

        return $builder->countAllResults() > 0;
    }
}