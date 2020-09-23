<?php
namespace common\helpers;

/**
 * 锁
 * 优点
 * 1、互斥（只有一个人等占有锁）
 * 2、有过期机制，不会有死锁
 * 3、不会误解锁。只有自己锁的自己解（或者等自然解锁）
 * 缺点：
 * 如果程序尚未结束，锁的时间到了，如何续锁？？？
 * Class LockRedisHelper
 * @package common\helpers
 */
class LockRedisHelper{
    private static $storeClient = [];


    /**
     * @param $scene             锁的场景key
     * @param int $expire        锁的有效时间
     * @param int $retry         上锁失败，是否重试，重试次数
     * @param int $retryTimeMs   上锁失败，重试的间隔时间。微秒。1s=100万微秒
     * @return bool  成功上锁true 否则false
     */
    public static function lock($scene, $expire=2, $retry=5, $retryTimeMs=100000){
        $key = self::getCompleteKey($scene);
        self::$storeClient[$key] = self::createUniqueClientID();
        $res = self::saveLock($key, self::$storeClient[$key], $expire);
        if($res){
            return $res;
        }else{
            if($retry > 0){
                usleep($retryTimeMs);
                return self::lock($scene, $expire, $retry - 1, $retryTimeMs);
            }
        }
        return false;
    }

    /**
     * 解锁
     * @param $scene
     * @return mixed  解锁成功1 否则false/null
     */
    public static function unlock($scene){
        $key = self::getCompleteKey($scene);
        return self::delLock($key);
    }

    /**
     * 真实存储锁
     * @param $key
     * @param $value
     * @param $expire
     * @return mixed
     */
    private static function saveLock($key, $value, $expire){
        return (self::connectDb())->set($key, $value, 'NX', 'EX', $expire);
    }

    /**
     * 真实解锁
     * @param $key
     * @return mixed
     */
    private static function delLock($key){
        $script = <<<lua
local key=KEYS[1]
local clientValue=ARGV[1]
if(redis.call("get",key)==clientValue) then
    return redis.call("del",key);
end
lua;
        return (self::connectDb())->eval($script, 1, $key, self::$storeClient[$key]);
    }

    /**
     * 链接数据库
     * @return mixed
     */
    private static function connectDb(){
        return \Yii::$app->redis;
    }

    /**
     * 对锁的key进行相关封装。前缀/空间等
     * @param $scene
     * @return string
     */
    private static function getCompleteKey($scene){
        return "local:".$scene;
    }

    /**
     * 生成一个当前客户端唯一标识。有用户UID的也可以用UID代替
     * @return string
     */
    private static function createUniqueClientID(){
        return 'lock_redis_' . session_create_id() .  rand(0, 99999);
    }
}