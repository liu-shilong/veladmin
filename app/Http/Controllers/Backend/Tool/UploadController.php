<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend\Tool;

use App\Libs\AdminCommonAction;
use App\Models\Tool\Upload;

class UploadController extends Tool
{
    use AdminCommonAction;

    protected string $model = Upload::class;
}
