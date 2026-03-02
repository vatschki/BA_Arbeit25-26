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
        'eu_member' => 'required|in_list[0,1]',
    ];

    public function getCountries(): array
    {
        return $this->orderBy('name_de', 'ASC')
                    ->findAll();
    }

    public function createCountry(array $data): int
    {
        if (!$this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new \RuntimeException(
                'Validation of Country failed: ' . implode(' | ', $errors)
            );
        }

        return (int)$this->getInsertID();
    }

    public function updateCountry(int $country_id, array $data): bool
    {
        if (! $this->update($country_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Country failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteCountry(int $country_id): bool
    {
        $country = $this->find($country_id);

        if (! $country) {
            throw new RuntimeException('Land nicht gefunden.');
        }

        return (bool) parent::delete($country_id);
    }

    public function exists(int $id): bool
    {
        return $this->where('id', $id)->countAllResults() > 0;
    }

}
