<?php

namespace App\Models\Tool;

use App\Libs\AdminBaseModel;

class Upload
{
    use AdminBaseModel;

    protected $table = 'vel_media';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'img', 'imgs', 'crop', 'video', 'file', 'files', 'create_time', 'update_time'];
}
