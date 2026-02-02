<?php

namespace App\Models;

use App\Models\BaseModel;
use RuntimeException;

class AuthorModel extends BaseModel
{
    protected $table = 'authors';
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

    public function getAuthors(): array
    {
        return $this->findAll();
    }

    public function createAuthor(array $data): int
    {
        if (! $this->insert($data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Author failed: ' . implode(' | ', $errors)
            );
        }

        return (int) $this->getInsertID();
    }

    public function updateAuthor(int $author_id, array $data): bool
    {
        if (! $this->update($author_id, $data)) {
            $errors = $this->errors() ?? [];

            throw new RuntimeException(
                'Validation of Author failed: ' . implode(' | ', $errors)
            );
        }

        return true;
    }

    public function deleteAuthor(int $author_id): bool
    {
        $author = $this->find($author_id);

        if (! $author) {
            throw new RuntimeException('Author nicht gefunden.');
        }

        return (bool) parent::delete($author_id);
    }

    public function exists(int $id): bool
    {
        return $this->where('id', $id)->countAllResults() > 0;
    }
}
