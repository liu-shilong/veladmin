<?php

namespace App\Models\System;

use App\Libs\AdminBaseModel;

class Admin
{
    use AdminBaseModel;

    protected $table = 'vel_admin';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'username', 'password', 'realname', 'status', 'note', 'create_time', 'update_time', 'last_time', 'last_ip'];
}
