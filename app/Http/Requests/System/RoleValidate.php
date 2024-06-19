<?php

declare(strict_types=1);

namespace App\Http\Requests\System;

use App\Libs\BaseValidate;
use App\Models\System\Role;
use Illuminate\Validation\Rule;

class RoleValidate extends BaseValidate
{
    public function rules(): array
    {
        return [
            'name' => 'required|min:2|max:30',
            'rolekey' => [
                'required',
                'min:3',
                'max:30',
                'alpha_dash',
                Rule::unique(Role::tableName())->where(function ($query) {
                    if (isset($this->data['id'])) {
                        return $query->where('id', '<>', $this->data['id']);
                    }

                    return $query;
                }),
            ],
            'listsort' => 'integer',
        ];
    }

    public function attributes(): array
    {
        return [
            'name' => '角色名称',
            'roleky' => '角色标识',
            'listsort' => '显示顺序',
        ];
    }
}
