<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend\System;

use App\Utils\Admin\DataScope;
use App\Utils\Result;
use App\Http\Requests\System\RoleValidate;
use App\Libs\AdminCommonAction;
use App\Models\System\Role;
use App\Services\System\AdminRoleService;
use App\Services\System\RoleMenuService;
use App\Services\System\RoleStructService;
use Illuminate\Contracts\View\View;
use Illuminate\Http\JsonResponse;

class RoleController extends System
{
    use AdminCommonAction;

    protected string $model = Role::class;

    protected string $validate = RoleValidate::class;

    /**
     * 首页渲染
     */
    protected function indexRender(): View
    {
        $root_id = config('veladmin.root_role_id');

        return $this->render('', ['root_id' => $root_id]);
    }

    /**
     * 角色授权
     */
    public function auth(): View|JsonResponse
    {
        if ($this->request->isMethod('POST')) {
            $role_id = $this->request->post('id', 0);
            $treeId = $this->request->post('treeId', '');
            $result = (new RoleMenuService())->update($role_id, $treeId);
            if (! $result) {
                return Result::error('授权发生错误');
            }

            return Result::success();
        } else {
            $role_id = $this->request->get('role_id', 0);
            if (! $role_id) {
                return $this->toError('参数错误');
            }
            $info = $this->model::bFind($role_id);
            if (empty($info)) {
                return $this->toError('角色信息不存在');
            }
            $menuList = (new RoleMenuService())->getRoleMenuList($role_id);

            return $this->render('', ['info' => $info, 'menuList' => implode(',', $menuList)]);
        }
    }

    /**
     * 角色数据权限
     */
    public function datascope(): View|JsonResponse
    {
        if ($this->request->isMethod('POST')) {
            $role_id = $this->request->post('id', 0);
            if (! $role_id) {
                return Result::error('参数错误');
            }
            $info = Role::bFind($role_id);
            if (empty($info)) {
                return $this->toError('角色信息不存在');
            }
            $dataList = DataScope::typeList(); //数据范围列表
            $data_scope = $this->request->post('data_scope', '');
            if (! $data_scope || ! array_key_exists($data_scope, $dataList)) {
                return Result::error('请选择数据范围');
            }
            $treeId = $this->request->post('treeId', '');
            $result = (new RoleStructService())->update($role_id, $data_scope == '8' ? $treeId : '');
            if (! $result) {
                return Result::error('发生错误了');
            }

            $result = Role::bUpdate(['id' => $role_id, 'data_scope' => $data_scope]);
            if ($result === false) {
                return Result::error('数据保存失败');
            }

            return Result::success();
        } else {
            $role_id = $this->request->get('role_id', 0);
            if (! $role_id) {
                return $this->toError('参数错误');
            }
            $info = Role::bFind($role_id);
            if (empty($info)) {
                return $this->toError('角色信息不存在');
            }
            $typeList = DataScope::typeList(); //数据范围列表
            $userStruct = RoleStructService::getRoleStructList($role_id);

            return $this->render('', ['info' => $info, 'typeList' => $typeList, 'userStruct' => implode(',', $userStruct)]);
        }
    }

    /**
     * 删除前判断
     */
    protected function deleteBefore(array $data): bool|string
    {
        $root_id = config('veladmin.root_role_id');
        if ($data['id'] == $root_id) {
            return '默认超管角色无法删除';
        }

        return true;
    }

    /**
     * 删除角色后
     */
    protected function deleteAfter(array $data): void
    {
        //删除对应的管理员角色信息
        (new AdminRoleService())->deleteByRole($data['id']);

        //删除对应的权限菜单信息
        (new RoleMenuService())->deleteByRole($data['id']);

        //删除对应角色数据权限信息
        (new RoleStructService())->deleteByRole($data['id']);
    }
}
