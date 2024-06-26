<?php

declare(strict_types=1);

namespace App\Services\System;

use App\Models\System\Struct;
use App\Utils\Functions;
use Illuminate\Support\Facades\DB;

class StructService
{
    /**
     * 当修改组织构架时，修改子类所有的parent_name和levels
     */
    public function updateExtendField($pid): bool
    {
        if (! $pid) {
            return false;
        }

        $parentInfo = Struct::bFind($pid);
        if (! $parentInfo) {
            return false;
        }

        $parent_name = trim($parentInfo['parent_name'].','.$parentInfo['name'], ',');
        $levels = trim($parentInfo['levels'].','.$parentInfo['id'], ',');
        $childList = DB::table(Struct::tableName())->where('parent_id', $pid)->get();
        $childList = $childList ? Functions::stdToArray($childList) : [];
        foreach ($childList as $child) {
            if ($child['parent_name'] != $parent_name || $child['levels'] != $levels) {
                $res = Struct::bUpdate(['id' => $child['id'], 'parent_name' => $parent_name, 'levels' => $levels]);
                if ($res) {
                    $this->updateExtendField($child['id']);
                }
            }
        }

        return true;
    }

    /**
     * 获取某个组织的所有子组织
     *
     * @param  bool  $onlyId
     */
    public static function getChildList($id, $onlyId = false): array
    {
        $list = [];
        if ($id > 0) {
            $list = DB::table(Struct::tableName())->whereRaw('FIND_IN_SET(?,levels)', $id)->get();
            $list = $list ? Functions::stdToArray($list) : [];
            if ($onlyId) {
                $list = array_column($list, 'id');
            }
        }

        return $list ?: [];
    }

    /**
     * 获取所有菜单，用于树形组件使用
     */
    public function getList(): array
    {
        $list = DB::table(Struct::tableName())->select(['id', 'parent_id', 'name'])->orderBy('parent_id', 'asc')->orderBy('listsort', 'asc')->orderBy('id', 'asc')->get();

        return $list ? Functions::stdToArray($list) : [];
    }
}
