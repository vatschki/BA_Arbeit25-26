<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class CountryModel extends BaseModel
{

    protected $table = 'countries';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'code',
        'name_de',
        'name_eng',
        'region',
        'eu_member'
    ];

    protected $validationRules = [
        'code' => 'required|min_length[3]|max_length[100]',
        'name_de' => 'required|min_length[3]|max_length[200]',
        'name_eng' => 'required|min_length[3]|max_length[200]',
        'region' => 'required|min_length[3]|max_length[200]',
        'eu_member' => 'required|boolean'
    ];

    public function getCountries(): array
    {
        return $this->findAll();
    }

    public function createCountry(array $data): int
    {
        if (!$this->insert($data)) {
            $errors = $this->errors() ?? [];

            // Hier kannst du auch eine eigene Exception-Klasse nehmen, wenn du willst
            throw new \RuntimeException(
                'Validation of Country failed: ' . implode(' | ', $errors)
            );
        }

        return (int)$this->getInsertID();
    }
}
