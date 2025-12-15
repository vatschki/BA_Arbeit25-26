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
        'title',
        'description'
    ];

    protected $validationRules = [
        'standard_id' => 'required|min_length[3]|max_length[100]',
        'code' => 'required|min_length[3]|max_length[100]',
        'title' => 'required|min_length[3]|max_length[200]',
        'description' => 'permit_empty|max_length[500]'
    ];

    public function getRequirements(): array
    {
        return $this->findAll();
    }
}