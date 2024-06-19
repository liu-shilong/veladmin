<?php

declare(strict_types=1);

namespace App\Services\System;

use App\Services\Cache\PositionCache;
use App\Utils\Functions;
use Illuminate\Support\Facades\DB;

class AdminPosService
{
    protected string $table = 'vel_admin_pos';

    /**
     * 更新信息
     */
    public function update($admin_id, string $pos_id = ''): bool
    {
        if (! $admin_id) {
            return false;
        }
        DB::table($this->table)->where('admin_id', $admin_id)->delete();
        if (! $pos_id) {
            return true;
        }
        $pos_id = explode(',', $pos_id);
        foreach ($pos_id as $role) {
            DB::table($this->table)->insert(['admin_id' => $admin_id, 'pos_id' => $role]);
        }

        return true;
    }

    /**
     * 获取某个人员的岗位列表
     *
     * @param  false  $showPos
     */
    public function getPosByAdmin($admin_id, $showPos = false): mixed
    {
        if (! $admin_id) {
            return [];
        }

        $info = DB::table($this->table)->where('admin_id', $admin_id)->first();
        if (! $info) {
            return [];
        }
        $info = Functions::stdToArray($info);
        if (! $showPos) {
            return $info['pos_id'];
        }

        $posList = PositionCache::lists();
        $posList = array_column($posList, null, 'id');

        return $posList[$info['pos_id']] ?? [];
    }

    /**
     * 删除某个岗位的管理员信息
     */
    public function deleteByPos($pos_id): bool
    {
        if ($pos_id) {
            DB::table($this->table)->where('pos_id', $pos_id)->delete();

            return true;
        }

        return false;
    }

    /**
     * 删除某个管理员的岗位信息
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
