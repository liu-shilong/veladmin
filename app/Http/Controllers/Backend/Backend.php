<?php

declare(strict_types=1);

namespace App\Http\Controllers\Backend;

use App\Libs\BaseController;
use App\Services\Cache\ConfigCache;

class Backend extends BaseController
{
    protected string $module = 'admin';

    public function __initialize(): void
    {

        parent::__initialize();
        if (! $this->request->ajax() && $this->request->isMethod('GET')) {
            view()->share('group', '/'.($this->module ? $this->module.'/' : '').($this->group ? $this->group.'/' : ''));
            view()->share('app', $this->controller);
            view()->share('act', $this->action);

            view()->share('system_name', ConfigCache::get('sys_config_sysname'));

        }
        $this->request->attributes->add(['group' => $this->group, 'controller' => $this->controller, 'action' => $this->action]);

    }
}
