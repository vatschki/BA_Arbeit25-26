<?php

namespace App\Models;

use App\Models\BaseModel;
use RuntimeException;

class AuditorModel extends BaseModel
{
    protected $table = 'auditors';
    protected $primaryKey = 'id';

    protected $allowedFields = [
        'name',
        'description',
        'type',
    ];

    protected $validationRules = [
        'name'        => 'required|min_length[3]|max_length[100]',
        'description' => 'permit_empty|max_length[500]',
        'type'        => 'permit_empty|max_length[100]',
    ];

    public function getAuditors(): array
    {
        return $this->findAll();
    }

    public function createAuditor(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Auditor failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }

    public function updateAuditor(int $auditor_id, array $data): bool
    {
        if (! $this->update($auditor_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Auditor failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteAuditor(int $auditor_id): bool
    {
        $auditor = $this->find($auditor_id);

        if (! $auditor) {
            throw new RuntimeException('Prüfer nicht gefunden.');
        }

        return (bool) parent::delete($auditor_id);
    }

    public function exists(int $id): bool
    {
        return $this->where('id', $id)->countAllResults() > 0;
    }
}
