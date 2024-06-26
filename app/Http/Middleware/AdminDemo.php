<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use App\Services\Cache\ConfigCache;
use App\Utils\Admin\LoginAuth;
use App\Utils\Result;
use Closure;
use Illuminate\Http\Request;

class AdminDemo
{
    /**
     * Handle an incoming request.
     *
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $controller = strtolower($request->get('controller'));
        $action = strtolower($request->get('action'));

        //不走演示判断的控制器、方法
        $notAuthController = ['public'];
        $notAuthAction = ['tree', 'lockscreen'];

        if (in_array($controller, $notAuthController) || in_array($action, $notAuthAction) || substr($action, 0, 4) === 'ajax') {
            return $next($request);
        }

        $noCheckAction = ['index'];
        if (($request->isMethod('POST') || $request->ajax()) && ! in_array($action, $noCheckAction)) {
            $model = ConfigCache::get('demo_mode');
            $is_admin = LoginAuth::adminLoginInfo('info.is_admin');
            if ($model == '1' && ! $is_admin) {
                return Result::error('演示模式，无法此操作', 500);
            }
        }

        return $next($request);
    }
}
