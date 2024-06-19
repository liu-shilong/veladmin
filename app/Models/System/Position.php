<?php

namespace App\Models\System;

use App\Libs\AdminBaseModel;

class Position
{
    use AdminBaseModel;

    protected $table = 'vel_position';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'name', 'poskey', 'listsort', 'status', 'note', 'create_time', 'update_time'];
}
