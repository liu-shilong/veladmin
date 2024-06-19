<?php

declare(strict_types=1);

namespace App\Libs;

use Illuminate\Support\Facades\Validator;

abstract class BaseValidate
{
    /**
     * 错误信息
     */
    protected string $error;

    /**
     * 验证的数据
     */
    protected array $data;

    /**
     * 验证场景
     */
    protected string $scene;

    /**
     * 验证规则
     */
    protected array $ruleList;

    /**
     * 初始化将验证规则赋值到属性
     * ValidateBase constructor.
     */
    public function __construct()
    {
        $this->ruleList = $this->rules();
    }

    /**
     * 验证规则
     */
    abstract protected function rules(): array;

    /**
     * 错误消息
     */
    protected function message(): array
    {
        return [];
    }

    /**
     * 自定义属性名称
     */
    protected function attributes(): array
    {
        return [];
    }

    /**
     * 验证场景
     */
    protected function scenes(): array
    {
        return [];
    }

    /**
     * 验证成功后的操作
     */
    protected function after_validate(): void
    {
    }

    /**
     * 验证前的操作
     */
    protected function before_validate(): void
    {
    }

    /**
     * 基于验证场景获取验证规则
     */
    protected function getRules(): array
    {
        $rules = $this->ruleList;
        if (! $rules) {
            return [];
        }
        if (! $this->scene) {
            return $rules;
        }

        //若指定场景则对验证规则调整
        $scenes = $this->scenes();
        if ($scenes && array_key_exists($this->scene, $scenes)) {
            foreach ($rules as $field => $rule) {
                if (! in_array($field, $scenes[$this->scene])) {
                    unset($rules[$field]);
                }
            }
        }

        return $rules;
    }

    /**
     * 赋值验证数据
     *
     * @return $this
     */
    public function setData(array $data): BaseValidate
    {
        $this->data = $data;

        return $this;
    }

    /**
     * 获取数据
     */
    public function getData(): array
    {
        return $this->data;
    }

    /**
     * 设置场景
     *
     * @return $this
     */
    public function setScene(string $scene): BaseValidate
    {
        $this->scene = $scene;

        return $this;
    }

    /**
     * 执行验证并返回错误信息
     */
    public function run(): string
    {
        $this->error = '';
        if (! $this->data) {
            $this->error = '没有提交数据';
        } else {
            $this->before_validate();
            if (! $this->error) {
                $rules = $this->getRules();
                if ($rules) {
                    $validator = Validator::make($this->data, $rules, $this->message(), $this->attributes());
                    if ($validator->stopOnFirstFailure()->fails()) {
                        $error = $validator->errors()->first();
                        $this->error = $error ?: '请确定提交信息的完整';
                    }
                }
                $this->after_validate();
            }
        }

        return $this->error;
    }
}
