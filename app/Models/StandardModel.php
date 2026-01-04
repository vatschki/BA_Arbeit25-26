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
        'description'
    ];

    protected $validationRules = [
        'code' => 'required|min_length[3]|max_length[100]',
        'name' => 'required|min_length[3]|max_length[100]',
        'description' => 'permit_empty|max_length[500]'
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
}

