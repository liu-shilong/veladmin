<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend\System;

use App\Libs\AdminCommonAction;
use App\Models\System\Notice;

class NoticeController extends System
{
    use AdminCommonAction;

    protected string $model = Notice::class;

    protected function indexBefore(array $params): array
    {
        $params['field'] = ['id', 'title', 'status', 'create_time'];

        return $params;
    }
}
