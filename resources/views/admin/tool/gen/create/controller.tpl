<?php

declare (strict_types = 1);

namespace App\Http\Controllers\Admin{$dir};

use App\Libs\AdminCommonAction;
use App\Models{$dir}\{$model};

class {$controller}Controller extends {$base}
{
    use AdminCommonAction;
    protected string $model = {$model}::class;


}
