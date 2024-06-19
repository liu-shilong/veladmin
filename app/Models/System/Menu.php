<?php

namespace App\Models\System;

use App\Libs\AdminBaseModel;

class Menu
{
    use AdminBaseModel;

    protected $table = 'vel_menu';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'name', 'parent_id', 'listsort', 'url', 'target', 'type', 'status', 'is_refresh', 'perms', 'icon', 'note', 'create_time', 'update_time'];
}
