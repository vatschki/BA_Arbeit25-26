<?php

namespace App\Models;

use App\Models\BaseModel;

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
            industries.name AS industry_name,
            countries.name_de AS country_name_de,
            countries.name_eng AS country_name_eng,
            sectors.name AS sector_name"
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

            // Hier kannst du auch eine eigene Exception-Klasse nehmen, wenn du willst
            throw new \RuntimeException(
                'Validation of Company failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }
}