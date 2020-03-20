<?php

/**
 * parent::                 从父类开始向上查询，有则调用
 * self::与类名             从自己向上查询，有则调用
 * $this->与（new class）   $this处于继承的最下层。意味着从最下层开始查询。有则调用
 */
class Top{
	static public $st = ''
    public static function baseStatic(){     echo "top<br/>"; }
}
class Base extends Top{
    public static function baseStatic(){     echo "base<br/>";}

    public function test1(){    parent::baseStatic();}
    public function test2(){    self::baseStatic(); }
    public function test3(){    $this->baseStatic();}
}
class Aa extends Base {
    public static function baseStatic(){    echo "aa<br/>";}

    public function test4(){    parent::baseStatic();}
}

Base::$st = "st";
Top::$st；//st
Aa::$st;  //st  任何一个对象调用$st都是st

Aa::baseStatic();  //输出aa   等同于self
$obj = new Aa();
$obj->baseStatic();//输出aa   等同于$this->
$obj->test1();     //输出top   parent::
$obj->test2();     //输出base  self::        self是当前文档
$obj->test3();     //输出aa    $this->       this是当前对象
$obj->test4();     //输出base  如果所有父类都有该方法。parent只能向上追一级父类。

//static::renderTable($targetKey);
die;

















// comment out the following two lines when deployed to production
defined('YII_DEBUG') or define('YII_DEBUG', true);
defined('YII_ENV') or define('YII_ENV', 'dev');

require __DIR__ . '/../vendor/autoload.php';
require __DIR__ . '/../vendor/yiisoft/yii2/Yii.php';

$config = require __DIR__ . '/../config/web.php';

(new yii\web\Application($config))->run();
