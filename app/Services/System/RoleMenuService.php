<?php

declare(strict_types=1);

namespace App\Services\System;

use App\Utils\Functions;
use Illuminate\Support\Facades\DB;

class RoleMenuService
{
    protected string $table = 'vel_role_menu';

    /**
     * 更新授权信息
     *
     * @param  string|array  $treeId
     */
    public function update($role_id, $treeId = null): bool
    {
        if (! $role_id) {
            return false;
        }

        if (! $this->deleteByRole($role_id)) {
            return false;
        }

        if (! $treeId) {
            return true;
        }
        if (! is_array($treeId)) {
            $treeId = explode(',', $treeId);
        }
        $treeId = array_unique($treeId);
        $data = [];
        foreach ($treeId as $menu_id) {
            if ($menu_id) {
                $data[] = ['role_id' => $role_id, 'menu_id' => $menu_id];
            }
        }
        DB::table($this->table)->insert($data);

        return true;
    }

    /**
     * 获取角色分组的菜单权限ID
     */
    public function getRoleMenuList($role_id): array
    {
        $list = [];
        if (is_array($role_id)) {
            foreach ($role_id as $role) {
                $chList = DB::table($this->table)->where('role_id', $role)->get();
                if ($chList) {
                    $chList = Functions::stdToArray($chList);
                    $chList = array_unique(array_column($chList, 'menu_id'));
                    $list = array_merge($list, $chList);
                }
            }
            $list = array_unique($list);
        } else {
            $list = Db::table($this->table)->where('role_id', $role_id)->get();
            if ($list) {
                $list = Functions::stdToArray($list);
                $list = array_unique(array_column($list, 'menu_id'));
            }
        }

        return $list ?: [];
    }

    /**
     * 删除某个角色的授权信息
     */
    public function deleteByRole($role_id): bool
    {
        if ($role_id) {
            DB::table($this->table)->where('role_id', $role_id)->delete();

            return true;
        }

        return false;
    }

    /**
     * 删除某个菜单的授权信息
     */
    public function deleteByMenu($menu_id): bool
    {
        if ($menu_id) {
            DB::table($this->table)->where('menu_id', $menu_id)->delete();

            return true;
        }

        return false;
    }
}
