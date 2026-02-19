<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class RequirementModel extends BaseModel{

    protected $table = 'esrs_requirements';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'standard_id',
        'code',
        'disclosure_requirement',
        'paragraph',
        'title',
        'data_type',
        'conditional_alternative_disclosure_requirement'
    ];

    protected $validationRules = [
        'standard_id' => 'required|integer',
        'code' => 'required|max_length[100]',
        'disclosure_requirement' => 'required|max_length[50]',
        'paragraph' => 'required|max_length[50]',
        'title' => 'required|max_length[500]',
        'data_type' => 'permit_empty|max_length[200]',
        'conditional_alternative_disclosure_requirement' => 'permit_empty|max_length[100]',
    ];

    public function getRequirements(): array
    {
        return $this->findAll();
    }

    public function getRequirementByIdAndStandard(int $requirementId, int $standardId): ?array
    {
        return $this->where('id', $requirementId)
            ->where('standard_id', $standardId)
            ->first();
    }

    public function getRequirementsByStandardId(int $standardId): ?array
    {
        return $this->where('standard_id', $standardId)
            ->findAll();
    }

    public function getRequirementBycode(string $code, int $standard_id): ?array
    {
        return $this
            ->where('code', $code)
            ->where('standard_id', $standard_id)
            ->first();
    }

    public function hasRequirementsForStandard(int $standard_id): bool
    {
        return $this->where('standard_id', $standard_id)
                ->countAllResults(false) > 0;
    }

    public function createRequirement(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new \RuntimeException(
                'Validation of Requirement failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }

    public function updateRequirement(int $requirement_id, array $data): bool
    {
        if (! $this->update($requirement_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Requirement failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteRequirement(int $requirement_id): bool
    {
        $requirement = $this->find($requirement_id);

        if (! $requirement) {
            throw new RuntimeException('Standard nicht gefunden.');
        }

        return (bool) parent::delete($requirement_id);
    }

}