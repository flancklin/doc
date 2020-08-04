<?php
namespace flancklin\session;

class SessionHelper{

    private $handler = null;
    function __construct($handler)
    {
        if($handler instanceof \SessionIdInterface) $this->handler = $handler;
    }

    /**
     * 设置或修改session值
     * @param $key
     * @param $value
     * @throws SessionStartFailException
     */
    public function set($key, $value){
        $this->open();//开启sessin
        $_SESSION[$key] = $value;
    }

    /**
     * 删除某个session值
     * @param $key
     * @throws SessionStartFailException
     */
    public function delete($key){
        $this->open();
        if(isset($_SESSION[$key])) unset($_SESSION[$key]);
    }

    /**
     * 获取某个session值
     * @param $key
     * @param null $default
     * @return mixed|null
     * @throws SessionStartFailException
     */
    public function get($key, $default = null){
        $this->open();
        return $_SESSION[$key] ?? $default;
    }

    /**
     * 如果session没有开启，则开启。
     * 如果session原本已开启，则无需多余操作
     * @throws SessionStartFailException
     */
    private function open(){
        if($this->isActive()) return ;
        //php_ini:session.auto_start =1不能使用session_set_save_handler
        //Warning: session_set_save_handler(): Cannot change save handler when session is active
        $this->handler && session_set_save_handler($this->handler);
        if(!session_start()){
            throw new SessionStartFailException('open session failed');
        }
    }

    /**
     * 判断session是否已开启
     * @return bool
     */
    private function isActive(){
        return session_status() == PHP_SESSION_ACTIVE;
    }
}
