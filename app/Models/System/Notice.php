<?php

namespace App\Models\System;

use App\Libs\AdminBaseModel;

class Notice
{
    use AdminBaseModel;

    protected $table = 'vel_notice';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'title', 'type', 'desc', 'content', 'status', 'create_time', 'update_time'];
}
