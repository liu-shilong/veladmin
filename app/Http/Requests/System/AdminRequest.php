<?php

declare(strict_types=1);

namespace App\Http\Requests\System;

use App\Libs\BaseValidate;
use App\Models\System\Admin;
use Illuminate\Validation\Rule;

class AdminRequest extends BaseValidate
{
    public function rules(): array
    {
        return [
            'username' => [
                'required',
                'min:3',
                'max:30',
                'alpha_dash',
                Rule::unique(Admin::tableName())->where(function ($query) {
                    if (isset($this->data['id'])) {
                        return $query->where('id', '<>', $this->data['id']);
                    }
                }),
            ],
            'password' => 'min:6|max:20',
        ];
    }

    public function attributes(): array
    {
        return [
            'username' => '登录名称',
            'password' => '登录密码',
        ];
    }
}
