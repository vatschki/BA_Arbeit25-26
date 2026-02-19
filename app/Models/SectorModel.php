<?php

namespace App\Models;

use App\Models\BaseModel;
use App\Models\IndustryModel;
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

            throw new \RuntimeException(
                'Validation of Sector failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }

    public function updateSector(int $sector_id, array $data): bool
    {
        if (! $this->update($sector_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Sector failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteSector(int $sector_id): bool
    {
        $sector = $this->find($sector_id);

        if (! $sector) {
            throw new RuntimeException('Sektor nicht gefunden.');
        }

        $industryModel = new IndustryModel();

        if ($industryModel->hasIndustryForSector($sector_id)) {
            throw new RuntimeException(
                'Sektor kann nicht gelöscht werden, da noch Industrien existieren.'
            );
        }

        return (bool) parent::delete($sector_id);
    }
}
