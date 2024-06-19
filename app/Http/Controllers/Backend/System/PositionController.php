<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend\System;

use App\Libs\AdminCommonAction;
use App\Models\System\Position;

class PositionController extends System
{
    use AdminCommonAction;

    protected string $model = Position::class;
}
