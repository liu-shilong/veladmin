<?php

namespace App\Models\System;

use App\Libs\AdminBaseModel;

class Struct
{
    use AdminBaseModel;

    protected $table = 'vel_struct';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'name', 'parent_name', 'parent_id', 'levels', 'listsort', 'leader', 'phone', 'status', 'note', 'create_time', 'update_time'];
}
