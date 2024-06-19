<?php

declare(strict_types=1);

namespace App\Http\Requests\System;

use App\Libs\BaseValidate;

class StructValidate extends BaseValidate
{
    public function rules(): array
    {
        return [
            'name' => 'required|min:2|max:30',
            'listsort' => 'integer',
        ];
    }

    public function attributes(): array
    {
        return [
            'name' => '组织名称',
            'listsort' => '显示顺序',
        ];
    }
}
