<?php

declare(strict_types=1);

namespace App\Services\System;

use App\Utils\Functions;
use App\Models\System\Menu;
use Illuminate\Support\Facades\DB;

class MenuService
{
    /**
     * 菜单类型
     */
    public function typeList(): array
    {
        return ['M' => '目录', 'C' => '菜单', 'F' => '按钮'];
    }

    /**
     * 获取所有菜单，用于树形组件使用
     */
    public function getList(bool $root = false): array
    {
        $list = DB::table(Menu::tableName())->select(['id', 'parent_id', 'name'])->orderBy('parent_id')->orderBy('listsort')->orderBy('id')->get();
        $list = $list ? Functions::stdToArray($list) : [];
        if ($root) {
            $first = [
                'id' => 0,
                'parent_id' => -1,
                'name' => '顶级菜单',
            ];
            array_unshift($list, $first);
        }

        return $list;
    }
}
