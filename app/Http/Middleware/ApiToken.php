<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use App\Utils\Result;
use App\Libs\ApiTraitToken;
use Closure;
use Illuminate\Http\Request;

/**
 * 判断token的过滤器
 */
class ApiToken
{
    use ApiTraitToken;

    /**
     * 平台类型
     */
    public string $type = '';

    /**
     * 接口登录参数
     */
    public string $key = 'token';

    /**
     * @param  string  $type  平台类型 例如 app和h5两个登录不影响彼此
     * @param  string  $key  验证字段 默认token
     * @param  bool  $noLogin  是否允许未登录，true时未登录不会直接返回未登录，需自己根据__token进行判断，主要用于某个控制器中登录或者未登录都可以进行的操作
     */
    public function handle(Request $request, Closure $next, string $type = '', string $key = '', bool $noLogin = false): mixed
    {
        $key = $key ?: 'token';
        $token = $request->input($key, '');
        $token_record = $this->getToken($token, $type);
        if (! $token_record && ! $noLogin) {
            if ($request->isMethod('POST') || $request->ajax()) {
                return Result::error('登录失效，请重新登录', 305);
            } else {
                return redirect(route('error', ['msg' => '登录失效，请重新登录', 'code' => 305]));
            }
        }
        //将token信息传递
        $request->attributes->add(['__token' => $token_record]);

        return $next($request);
    }
}
