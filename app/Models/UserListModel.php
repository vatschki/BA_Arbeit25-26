<?php

namespace App\Models;

use App\Models\BaseModel;

class UserListModel extends BaseModel
{
    protected $table = 'users';
    protected $returnType = 'object';

    public function getUsersWithEmailAndRole()
    {
        return $this->select('
                users.id,

                MAX(users.username)    AS username,
                MAX(users.active)      AS active,
                MAX(users.created_at)  AS created_at,
                MAX(auth_identities.secret) AS email,

                CASE
                    WHEN SUM(auth_groups_users.group = "admin") > 0 THEN "admin"
                    WHEN SUM(auth_groups_users.group = "sub_admin") > 0 THEN "sub_admin"
                    WHEN SUM(auth_groups_users.group = "user") > 0 THEN "user"
                    ELSE NULL
                END AS role
            ')
            ->join('auth_identities', 'auth_identities.user_id = users.id')
            ->join('auth_groups_users', 'auth_groups_users.user_id = users.id', 'left')
            ->where('auth_identities.type', 'email_password')
            ->where('users.deleted_at', null)
            ->groupBy('users.id')
            ->orderBy('username', 'ASC')
            ->findAll();
    }
}
