<?php

declare(strict_types=1);

namespace App\Utils;

class ResultArray
{
    /**
     * 成功的JSON
     */
    public static function success(string $msg = '', array $data = [], array $extend = []): array
    {
        return static::message($msg, true, $data, 0, $extend);
    }

    /**
     * 失败JSON
     */
    public static function error(string $msg = '', int $code = 500): array
    {
        return static::message($msg, false, [], $code);
    }

    /**
     * 返回json响应信息
     */
    public static function message(string $msg, bool $success, array $data, int $code = -1, array $extend = []): array
    {
        $rs = [
            'code' => $code < 0 ? ($success ? 0 : 500) : $code,
            'msg' => $msg ?: ($success ? '操作成功' : '操作失败'),
            'data' => $data,
            'success' => $success,
        ];
        if ($extend) {
            foreach ($extend as $key => $value) {
                $rs[$key] = $value;
            }
        }

        return $rs;
    }
}
