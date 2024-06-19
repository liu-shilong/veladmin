<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend\Tool;

use Illuminate\Contracts\View\View;

class FormController extends Tool
{
    /**
     * 表单构建
     */
    public function build(): View
    {
        return $this->render();
    }
}
