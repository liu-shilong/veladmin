<?php

declare(strict_types=1);

namespace App\Exceptions;

use App\Utils\Result;
use Exception;
use Illuminate\Http\Request;

class BusinessException extends Exception
{
    //自定义异常 渲染
    public function render(Request $request)
    {
        if ($request->isMethod('POST') || $request->ajax()) {
            return Result::error($this->getMessage(), $this->getCode());
        } else {
            return view('error', ['msg' => $this->getMessage(), 'code' => $this->getCode()]);
        }
    }
}
