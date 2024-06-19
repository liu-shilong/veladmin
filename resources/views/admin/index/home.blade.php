@extends('admin.layout.layout')
@section('title', '主页')

@section('content')
    <style>
        .system-info td{
            padding-bottom: 20px;
        }
    </style>
    <div class="mt10" style="background-color: #fff;padding: 20px">
        <div class="row">
            <div class="col-sm-6">
                <table class="system-info">
                    <tbody>
                        <tr>
                            <td>操作系统：</td>
                            <td>@php echo PHP_OS @endphp</td>
                        </tr>
                        <tr>
                            <td>服务器IP：</td>
                            <td>@php echo $_SERVER['SERVER_ADDR'] @endphp</td>
                        </tr>
                        <tr>
                            <td>CPU核数：</td>
                            <td>{{$cpucores}}</td>
                        </tr>
                        <tr>
                            <td>内存占用：</td>
                            <td>{{round($diskusedize,2)}} GB /
                                {{round($disktotalsize,2)}} GB ({{$diskuse}})
                            </td>
                        </tr>
                        <tr>
                            <td>PHP版本：</td>
                            <td>@php echo PHP_VERSION @endphp</td>
                        </tr>
                        <tr>
                            <td>Laravel版本：</td>
                            <td>Laravel v{{ Illuminate\Foundation\Application::VERSION }}</td>
                        </tr>
                        <tr>
                            <td>UserAgent：</td>
                            <td>@php echo $_SERVER['HTTP_USER_AGENT'] @endphp</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
@endsection

