<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class IndustryModel extends BaseModel{

    protected $table = 'industries';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'name',
        'sector_id',
        'description'
    ];

    protected $validationRules = [
        'name' => 'required|min_length[3]|max_length[100]',
        'sector_id' => 'required|integer',
        'description' => 'permit_empty|max_length[500]'
    ];

    public function getIndustriesWithSectors(): array
    {
        return $this->select("
            industries.id,
            industries.name,
            industries.description,
            industries.sector_id,
            sectors.name AS sector_name
        ")
            ->join('sectors', 'industries.sector_id = sectors.id', 'left')
            ->findAll();
    }

    public function getIndustries(): array
    {
        return $this->findAll();
    }

    public function createIndustry(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new \RuntimeException(
                'Validation of Industry failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }

    public function updateIndustry(int $industry_id, array $data): bool
    {
        if (! $this->update($industry_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Industry failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteIndustry(int $industry_id): bool
    {
        $industry = $this->find($industry_id);

        if (! $industry) {
            throw new RuntimeException('Industry nicht gefunden.');
        }

        return (bool) parent::delete($industry_id);
    }

    public function hasIndustryForSector(int $sector_id): bool
    {
        $count = $this->where('sector_id', $sector_id)
            ->countAllResults();

        return $count > 0;
    }

    public function exists(int $id): bool
    {
        return $this->where('id', $id)->countAllResults() > 0;
    }

}
