<?php

namespace App\Models\System;

use App\Utils\Functions;
use App\Utils\IpLocation\IpLocation;
use App\Utils\UserAgent\Agent;
use App\Libs\AdminBaseModel;

class Loginlog
{
    use AdminBaseModel;

    protected $table = 'vel_login_log';

    protected $primaryKey = 'id';

    public $incrementing = true;

    public $timestamps = true;

    const CREATED_AT = 'create_time';

    const UPDATED_AT = 'update_time';

    protected $fillable = ['id', 'login_name', 'ipaddr', 'login_location', 'browser', 'os', 'net', 'status', 'msg', 'create_time', 'update_time'];

    //添加日志
    public static function logAdd($login_name, $status, $msg)
    {
        $agent = new Agent();
        $os = $agent->platform().' '.$agent->version($agent->platform());
        $browser = $agent->browser().' '.$agent->version($agent->browser());
        $ip_addr = Functions::getClientIp();
        $login_location = '';
        $net = '';
        if ($ip_addr) {
            $ipLocation = new IpLocation();
            $location = $ipLocation->getlocation($ip_addr);
            if ($location) {
                if ($location['country']) {
                    $login_location = iconv('GBK', 'UTF-8', $location['country']);
                }
                if ($location['area']) {
                    $net = iconv('GBK', 'UTF-8', $location['area']);
                }
            }
        }
        $data = ['login_name' => $login_name, 'ipaddr' => $ip_addr, 'browser' => $browser, 'os' => $os, 'status' => $status, 'msg' => $msg, 'login_location' => $login_location, 'net' => $net];
        self::bInsert($data);
    }
}
