<?php

namespace App\Models{$dir};

use App\Libs\AdminBaseModel;
use Illuminate\Database\Eloquent\Model;

class {$model} extends Model
{
    use AdminBaseModel;

    protected $table = '{$table}';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = [{$fields}];
}
