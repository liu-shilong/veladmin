<?php

namespace App\Models\System;

use App\Libs\AdminBaseModel;

class Config
{
    use AdminBaseModel;

    protected $table = 'vel_config';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'title', 'type', 'style', 'groups', 'value', 'extra', 'note', 'create_time', 'update_time'];
}
