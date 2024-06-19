<?php

declare(strict_types=1);

namespace App\Utils;

class Transform
{
    /**
     * 时间处理
     *
     * @return false|string
     */
    public static function timeAgo($timestamp): bool|string
    {
        $counttime = time() - $timestamp; //相差时间戳
        if ($counttime <= 60) {
            return '刚刚';
        } elseif ($counttime < 3600) {
            return intval(($counttime / 60)).'分钟前';
        } elseif ($counttime >= 3600 && $counttime < 3600 * 24) {
            return intval(($counttime / 3600)).'小时前';
        } elseif ($counttime <= 3600 * 24 * 10) {
            return intval(($counttime / (3600 * 24))).'天前';
        } else {
            return date('Y-m-d', $timestamp);
        }
    }

    /**
     * 容量显示
     *
     * @param  int  $size  字节
     */
    public static function sizeFormat(int $size): string
    {
        if ($size < 0) {
            return '';
        }
        $coin = 'Byte';
        $b_size = 1024;
        $kb_size = $b_size * 1024;
        $mb_size = $kb_size * 1024;
        $gb_size = $mb_size * 1024;
        if ($size >= 0 && $size < $b_size) {
            $number = $size;
        } elseif ($size >= $b_size && $size < $mb_size) {
            $number = floor(($size / $b_size) * 100) / 100;
            $coin = 'KB';
        } elseif ($size >= $mb_size && $size < $gb_size) {
            $number = floor(($size / $mb_size) * 100) / 100;
            $coin = 'MB';
        } else {
            $number = floor(($size / $gb_size) * 100) / 100;
            $coin = 'GB';
        }

        return $number.$coin;
    }
}
