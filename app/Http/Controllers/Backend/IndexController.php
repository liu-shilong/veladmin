<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend;

use App\Models\System\Menu;
use App\Utils\Admin\LoginAuth;
use App\Utils\Functions;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\DB;

class IndexController extends Backend
{
    /**
     * 首页
     */
    public function index(): View
    {
        //是否开启横向菜单
        $topNav = false;
        $style = $this->request->cookies->get('nav-style', 'left');
        if ($style == 'top') {
            $topNav = true;
        }

        $userInfo = LoginAuth::adminLoginInfo();
        $menuList = $this->getMenuListByLogin();
        if ($topNav) {
            return $this->render('index.indextop', ['user_info' => $userInfo, 'menuList' => $menuList]);
        }
        $menuHtml = $this->menuToHtml($menuList);

        return $this->render('', ['user_info' => $userInfo, 'menuHtml' => $menuHtml]);
    }

    /**
     * 主页
     */
    public function home(): View
    {
        $disktotal = disk_total_space('/'); // 已用空间
        $disktotalsize = $disktotal / 1073741824;

        $diskfree = disk_free_space('/');
        $used = $disktotal - $diskfree;

        $diskusedize = $used / 1073741824;
        $diskuse1 = round(100 - (($diskusedize / $disktotalsize) * 100));
        $diskuse = round(100 - ($diskuse1)).'%';

        // 获取操作系统类型
        $os = strtolower(PHP_OS);

        if ($os === 'linux') {
            // 在Linux系统中使用lscpu命令获取CPU信息
            $cpuinfo = shell_exec('lscpu');
            preg_match('/^CPU\(s\):\s*([0-9]+)/m', $cpuinfo, $matches);
            $cpucores = $matches[1];
        } elseif ($os === 'winnt') {
            // 在Windows系统中使用wmic命令获取CPU信息
            $cpuinfo = shell_exec('wmic cpu get NumberOfCores');
            $cpucores = intval(preg_replace('/\D/', '', $cpuinfo));
        } else {
            // 其他操作系统可以在此处添加相应的命令
            $cpucores = null;
        }

        return $this->render('index.home', compact('diskuse', 'disktotalsize', 'diskusedize', 'cpucores'));
    }

    /**
     * 主题
     */
    public function skin(): View
    {
        return $this->render();
    }

    /**
     * 菜单样式
     */
    public function navStyle(): View|\Illuminate\Http\JsonResponse
    {
        $type = trim($this->request->get('type', 'left'));
        $cookie = Cookie::make('nav-style', $type, 24 * 60 * 10);

        return $this->success('切换成功', ['cookie' => $cookie]);
    }

    public function download()
    {
        $fileName = $this->request->get('fileName', '');
        if (! $fileName) {
            return $this->toError('参数错误');
        }
        header('location:'.$fileName);
    }

    /**
     * 根据登录session获取菜单
     */
    protected function getMenuListByLogin(): array
    {
        $menuList = $menuTree = [];
        $adminId = LoginAuth::adminLoginInfo('info.id');
        if ($adminId) {
            $isAdmin = LoginAuth::adminLoginInfo('info.is_admin');

            if ($isAdmin) {
                $menuList = DB::table(Menu::tableName())->select(['id', 'type', 'name', 'url', 'parent_id', 'icon', 'is_refresh', 'target'])->where('type', '<>', 'F')->where('status', 1)->orderBy('parent_id')->orderBy('listsort')->orderBy('id')->get();
            } else {
                $menuIdList = LoginAuth::adminLoginInfo('menu');
                if ($menuIdList) {
                    //获取菜单
                    $menuList = DB::table(Menu::tableName())->select(['id', 'type', 'name', 'url', 'parent_id', 'icon', 'is_refresh', 'target'])->whereIn('id', $menuIdList)->where('type', '<>', 'F')->where('status', 1)->orderBy('parent_id')->orderBy('listsort')->orderBy('id')->get();
                }
            }
        }

        if ($menuList) {
            $menuTree = $this->getMenuTree(Functions::stdToArray($menuList));
        }

        return $menuTree;
    }

    /**
     * 将菜单转为数形无限极
     *
     * @param  int  $pid
     * @param  int  $deep
     */
    protected function getMenuTree($list, $pid = 0, $deep = 0): array
    {
        $tree = [];
        foreach ($list as $key => $row) {
            if ($row['parent_id'] == $pid) {
                $row['deep'] = $deep;
                if ($row['type'] == 'C') {
                    $url = $row['url'];
                    if ($url && strpos($url, 'http') !== 0) {
                        $url = url('/admin/'.$url);
                    }
                    $row['url'] = $url;
                }

                unset($list[$key]);
                $row['child'] = $this->getMenuTree($list, $row['id'], $deep + 1);
                $tree[] = $row;
            }
        }

        return $tree;
    }

    /**
     * 将菜单树形转为html
     *
     * @param  int  $deep
     */
    protected function menuToHtml($menus, $deep = 0): string
    {
        $html = '';
        if (is_array($menus)) {
            foreach ($menus as $t) {
                if ($t['deep'] == $deep) {
                    if ($t['type'] == 'C') {
                        $url = $t['url'];
                        if ($t['parent_id'] == 0) {
                            $html .= '<li><a class="'.($t['target'] == '1' ? 'menuBlank' : 'menuItem').'" href="'.$url.'" data-refresh="'.($t['is_refresh'] ? 'true' : 'false').'">'.($t['icon'] ? '<i class="'.$t['icon'].'"></i>' : '').' <span class="nav-label">'.$t['name'].'</span></a></li>';
                        } else {
                            $html .= '<li><a class="'.($t['target'] == '1' ? 'menuBlank' : 'menuItem').'" href="'.$url.'" data-refresh="'.($t['is_refresh'] ? 'true' : 'false').'">'.$t['name'].'</a></li>';
                        }

                    } else {
                        //实现最多三级菜单
                        if ($t['child'] && $deep < 3) {
                            $html .= '<li><a href="javascript:;">'.($t['icon'] ? '<i class="'.$t['icon'].'"></i>' : '').' <span class="nav-label">'.$t['name'].'</span><span class="fa arrow"></span></a>';
                            $html .= '<ul class="nav '.($deep == 0 ? 'nav-second-level' : 'nav-third-level').'">';
                            $html .= $this->menuToHtml($t['child'], $deep + 1);
                            $html = $html.'</ul></li>';
                        }
                    }
                }

            }
        }

        return $html;
    }
}
