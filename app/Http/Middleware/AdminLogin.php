<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use App\Utils\Admin\LoginAuth;
use App\Utils\Result;
use App\Extends\Services\System\AdminLoginService;
use Closure;
use Illuminate\Http\Request;

class AdminLogin
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next): mixed
    {
        //不需要登录的控制器
        $route = $request->route();

        if (! empty($route)) {
            $controller = strtolower($route->getActionName());
            $noLogin = ['public'];
            if (in_array($controller, $noLogin)) {
                return $next($request);
            }
        }

        //是否登录
        $loginInfo = LoginAuth::adminLoginInfo();
        if ($loginInfo) {
            return $next($request);
        }

        //判断cookie
        if ($this->autoLoginByCookie()) {
            return $next($request);
        }

        //跳转登录
        if (! $request->ajax() && $request->isMethod('GET')) {
            return redirect(route('admin.login'));
        } else {
            return Result::error('请先登录', 101);
        }

    }

    /**
     * 判断cookie是否存在并登录
     */
    public function autoLoginByCookie(): bool
    {
        $userid = \Illuminate\Support\Facades\Cookie::get(config('app.admin_login_cookie'));
        if (! $userid) {
            return false;
        }
        $userinfo = (new AdminLoginService())->loginSession($userid);
        if (! $userinfo) {
            return false;
        }

        return true;
    }
}
