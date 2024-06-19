<?php

declare(strict_types=1);

namespace App\Services\System;

use App\Utils\Functions;
use App\Models\System\Role;
use Illuminate\Support\Facades\DB;

class AdminRoleService
{
    protected string $table = 'vel_admin_role';

    /**
     * 更新信息
     */
    public function update($admin_id, string $role_id = ''): bool
    {
        if (! $admin_id) {
            return false;
        }
        DB::table($this->table)->where('admin_id', $admin_id)->delete();
        if (! $role_id) {
            return true;
        }
        $role_id = explode(',', $role_id);
        foreach ($role_id as $role) {
            DB::table('vel_admin_role')->insert(['admin_id' => $admin_id, 'role_id' => $role]);
        }

        return true;
    }

    /**
     * 获取某个人员的角色列表
     *
     * @param  false  $showRole
     */
    public function getRoleByAdmin($admin_id, $showRole = false): array
    {
        if (! $admin_id) {
            return [];
        }
        $list = DB::table($this->table)->where('admin_id', $admin_id)->get();
        $list = $list ? Functions::stdToArray($list) : [];
        if (! $showRole) {
            return $list ? array_column($list, 'role_id') : [];
        }
        $result = [];
        foreach ($list as $value) {
            $info = Role::bFind($value['role_id']);
            if ($info) {
                $result[] = $info;
            }
        }

        return $result;
    }

    /**
     * 获取某个角色下的所有用户ID
     */
    public function getAdminIdByRoleId($role_id): array
    {
        if (! $role_id) {
            return [];
        }
        $list = DB::table($this->table)->where('role_id', $role_id)->get();
        $list = $list ? Functions::stdToArray($list) : [];

        return $list ? array_column($list, 'admin_id') : [];
    }

    /**
     * 删除某个角色的管理员信息
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
     * 删除某个管理员的角色信息
     */
    public function deleteByAdmin($admin_id): bool
    {
        if ($admin_id) {
            DB::table($this->table)->where('admin_id', $admin_id)->delete();

            return true;
        }

        return false;
    }
}
