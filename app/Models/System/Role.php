<?php

namespace App\Models\System;

use App\Libs\AdminBaseModel;

class Role
{
    use AdminBaseModel;

    protected $table = 'vel_role';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'name', 'rolekey', 'listsort', 'data_scope', 'status', 'note', 'create_time', 'update_time'];
}
