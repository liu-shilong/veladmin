<?php

declare(strict_types=1);

namespace App\Libs;

use App\Utils\Result;
use Illuminate\Contracts\View\View;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class BaseController extends Controller
{
    /**
     * 模块名称
     */
    protected string $module = '';

    /**
     * 分组名称
     * 二级控制器的文件夹名称
     */
    protected string $group = '';

    /**
     * 控制器名称
     */
    protected string $controller;

    /**
     * 方法名称
     */
    protected string $action;

    /**
     * Request实例
     */
    protected Request $request;

    /**
     * 构造函数
     * BaseController constructor.
     */
    public function __construct(Request $request)
    {
        $this->request = $request;
        $this->__initialize();
    }

    /**
     * 自定义的初始化方法
     */
    public function __initialize(): void
    {
        $routeName = $this->request->route()->getActionName();
        [$controller, $action] = explode('@', $routeName);
        $controller = str_replace('Controller', '', class_basename($controller));
        $this->controller = strtolower($controller);
        $this->action = $action;
    }

    /**
     * 跳转到错误页
     */
    public function toError(string $msg = '发生错误了', int $code = 400): View|JsonResponse
    {
        if ($this->request->isMethod('POST') || $this->request->ajax()) {
            return Result::error($msg, $code);
        } else {
            $data = ['msg' => $msg, 'code' => $code];

            return $this->render('/error', $data);
        }
    }

    /**
     * 简化toError
     */
    public function error(string $msg = '发生错误了', int $code = 400): View|JsonResponse
    {
        return $this->toError($msg, $code);
    }

    /**
     * 成功或者成功页
     */
    public function success(string $msg = '操作成功', array $data = [], array $extend = []): View|JsonResponse
    {
        if ($this->request->isMethod('POST') || $this->request->ajax()) {
            return Result::success($msg, $data, $extend);
        } else {
            $data = ['msg' => $msg, 'code' => 200];

            return $this->render('/success', $data);
        }
    }

    /**
     * 快捷视图
     */
    protected function render(string $view = '', array $data = []): View
    {
        if (empty($view)) {
            $view = $this->controller.'.'.$this->action;
        }
        if (($this->module || $this->group) && strpos($view, '/') !== 0) {
            $view = ($this->module ? $this->module.'.' : '').($this->group ? $this->group.'.' : '').$view;
        }

        return view($view, $data);
    }
}
