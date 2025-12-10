<?php

namespace App\Models;

use CodeIgniter\Model;

abstract class BaseModel extends Model{

    protected $useTimestamps = false;
    protected $useSoftDeletes = false;
    protected $returnType = 'array';
}