<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class StandardModel extends BaseModel{

    protected $table = 'esrs_standards';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'code',
        'name',
        'description',
        'description_eng',
    ];

    protected $validationRules = [
        'code' => 'required|min_length[2]|max_length[100]',
        'name' => 'required|min_length[2]|max_length[100]',
        'description' => 'required|max_length[500]',
        'description_eng' => 'required|max_length[500]',
    ];

    public function getStandards(): array
    {
        return $this->findAll();
    }

    public function getStandardCodeById(int $standard_id)
    {
        return $this->select("code")
            ->where("id", $standard_id)
            ->first();
    }

    public function getStandardById(int $standard_id): array
    {
        return $this->select([
            'code',
            'name',
            'description',
            'description_eng'
        ])
            ->where('id', $standard_id)
            ->first();
    }

    public function createStandard(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new \RuntimeException(
                'Validation of Standard failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }

    public function updateStandard(int $standard_id, array $data): bool
    {
        if (! $this->update($standard_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Standard failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteStandard(int $standard_id): bool
    {
        $standard = $this->find($standard_id);

        if (! $standard) {
            throw new RuntimeException('Standard nicht gefunden.');
        }

        $requirementModel = new RequirementModel();

        if ($requirementModel->hasRequirementsForStandard($standard_id)) {
            throw new RuntimeException(
                'Standard kann nicht gelöscht werden, da noch Anforderungen existieren.'
            );
        }

        return (bool) parent::delete($standard_id);
    }
}

