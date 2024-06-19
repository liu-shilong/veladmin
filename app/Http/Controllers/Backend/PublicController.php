<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend;

use App\Services\Cache\ConfigCache;
use App\Utils\Admin\LoginAuth;
use App\Extends\Services\System\AdminLoginService;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\View;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Routing\Redirector;

class PublicController extends Backend
{
    /**
     * 登录
     */
    public function login(): View|JsonResponse|Redirector|Application|RedirectResponse
    {
        if ($this->request->isMethod('POST')) {
            return (new AdminLoginService())->login($this->request->post());
        } else {
            if (LoginAuth::adminLoginInfo()) {
                return redirect(route('admin.index'));
            } else {
                $systemname = ConfigCache::get('sys_config_sysname');

                return $this->render('public.login', compact('systemname'));
            }
        }
    }

    /**
     * 退出登录
     */
    public function logout(): Redirector|Application|RedirectResponse
    {
        (new AdminLoginService())->logout();

        return redirect(route('admin.login'));
    }
}
