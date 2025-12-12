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

    public function createSector(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new \RuntimeException(
                'Validation of Industry failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }
}
