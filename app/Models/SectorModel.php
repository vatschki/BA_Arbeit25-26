<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class SectorModel extends BaseModel{

    protected $table = 'sectors';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'name',
        'description'
    ];

    protected $validationRules = [
        'name' => 'required|min_length[3]|max_length[100]',
        'description' => 'permit_empty|max_length[500]'
    ];

    public function getSectors(): array
    {
        return $this->findAll();
    }

    public function createSector(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            // Hier kannst du auch eine eigene Exception-Klasse nehmen, wenn du willst
            throw new \RuntimeException(
                'Validation of Sector failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }
}
