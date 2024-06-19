<?php

declare(strict_types=1);

namespace App\Services\Cache;

use App\Utils\Functions;
use App\Extends\Services\System\ConfigService;
use App\Models\System\Config;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class ConfigCache
{
    /**
     * 获取配置值
     *
     * @param  null  $default
     */
    public static function get(?string $type = null, $default = null): mixed
    {
        if (! $type) {
            return $default;
        }
        $list = self::lists();

        return isset($list[$type]) ? $list[$type]['value'] : $default;
    }

    /**
     * 获取配置列表
     */
    public static function lists(): array
    {
        return Cache::rememberForever('config_list', function () {
            $result = [];
            $lists = DB::table(Config::tableName())->select(['type', 'value', 'extra', 'style'])->get();
            if ($lists) {
                $lists = Functions::stdToArray($lists);
                $service = new ConfigService();
                foreach ($lists as $key => $value) {
                    $result[$value['type']] = $service->formatFilter($value);
                }
            }

            return $result;
        });
    }

    /**
     * 清除所有
     */
    public static function clear()
    {
        Cache::forget('config_list');
    }
}
