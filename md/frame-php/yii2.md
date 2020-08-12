# 一、入门须知

## (一)、环境需求

## (二)、安装

### 1、composer(create-project)

### 2、归档文件(.rar)

## (三)、文档结构

### yii2-app-advanced

#### |+ backend (==模块==)

#### |+ frontend (==模块==)

​                        backend常用来作后台管理

​                        frontend常用来作前端接口。根本上来说，两者没区别，只是目录名称不一样

##### |			|+ assets

###### |			|		|- AppAsset.php

##### |			|+ config

###### |			|		|- .gitignore

###### |			|		|- bootstrap.php

###### |			|		|- main.php

###### |			|		|- params.php

###### |			|		|- test.php

##### |			|+ controllers

###### |			|		|- SiteController.php

##### |			|+ models

###### |			|		|- .gitkeep

##### |			|+ runtime

###### |			|		|- .gitignore

##### |			|+ tests

##### |			|+ views

###### |			|		|+ layouts

|			|		|		|- main.php

###### |			|		|- site

|			|		|		|- error.php

|			|		|		|- index.php

|			|		|		|- login.php

##### |			|+ web

###### |			|		|+ assets

###### |			|		|+ css

###### |			|		|- favicon.ico

##### |			|- codeception.yml

##### |			|- Dokerfile

#### |+ common (==公共==)

##### |			|+ config

###### |			|		|- .gitignore

###### |			|		|- bootstrap.php

###### |			|		|- main.php

###### |			|		|- params.php

###### |			|		|- test.php

##### |			|+ fixtures

###### |			|		|- UserFixture.php

##### |			|+ mail

###### |			|		|+ layouts

|			|		|		|- html.php

|			|		|		|- text.php

###### |			|		|- emailVerify-html.php

###### |			|		|- emailVerify-text.php 

###### |			|		|- passwordResetToken-html.php

###### |			|		|- passwordResetToken-text.php

##### |			|+ models

###### |			|		|- LoginForm.php

###### |			|		|- User.php

##### |			|+ tests

##### |			|+ widgets

##### |			|- codeception.yml

#### |+ console (==cli==)

##### |			|+ config

##### |			|+ controllers

##### |			|+ migrations

##### |			|+ models

##### |			|+ runtime

#### |+ environments

##### |			|+ dev

##### |			|+ prod

##### |			|- index.php

#### |+ vagrant

##### |			|+ config

##### |			|+ nginx

##### |			|+ provision

#### |- bowerrc 			

#### |- .gitignore

#### |- codeception.yml

#### |- composer.json

#### |- docker-compose.yml

#### |- init

#### |- init.bat

#### |- LICENSE.md

#### |- README.md

#### |- requirements.php

#### |- Vagrantfile

#### |- yii.bat

## (四)、hello world

## (五)、文档文献

**官网**

* https://www.yiichina.com/doc/guide/2.0

# 二、核心

一根藤(Yii)上接了无数个瓜(组件)





## (一)、路由router

### 1、设置默认路由

详细见 【控制器controller】 -> 【设置默认controller和默认action】

## (二)、请求request

## (三)、控制器controller

### 1、配置与设置

#### (1)、命名规则

| 类容       | 举例                       | 路由解析    | 解释                                                         |
| ---------- | -------------------------- | ----------- | ------------------------------------------------------------ |
| controller | HelloWorldController.php   | hello-world |                                                              |
| action     | `actionSayHello($p1, $p2)` | say-hello   | 1. 必须action开头<br>2.支持带参数。<br>参数来源可以是调用赋值，也可以是get传递 |



##### a、controller

##### b、action

#### (2)、设置默认controller和默认action

>设置默认controller和默认action的根本在于==设置默认路由==
>
>config/main.php
>
>* ```php
>  'defaultRoute' => 'hello-world',///或者hello-world/say-hello
>  ```
>```
>
>在controller中设置默认action
>
>* ```php
> class HelloWorldController extends \yii\web\Controller{
>  	public $defaultAction = 'say-hello';//设置默认方法
>  }
>```

### 2、controller种类与使用

#### (1)、种类

| 分类                      | 父类                | 功能     | 备注 |
| ------------------------- | ------------------- | -------- | ---- |
| yii\base\Controller       | yii\base\Component  |          |      |
| yii\console\Controller    | yii\base\Controller | cli指令  |      |
| yii\web\Controller        | yii\base\Controller | 渲染输出 |      |
| yii\rest\Controller       | yii\web\Controller  | api接口  |      |
| yii\rest\ActiveController | yii\rest\Controller |          |      |

#### (2)、web-controller

* **yii\web\Controller**

##### a、渲染view

| 方法                                      | 物理位置            | 功能                   |
| ----------------------------------------- | ------------------- | ---------------------- |
| `render($view, $params = [])`             | yii\base\Controller | 渲染view+layout        |
| `public function renderContent($content)` | yii\base\Controller | 渲染layout             |
| `renderPartial($view, $params = [])`      | yii\base\Controller | 渲染view               |
| `renderFile($file, $params = [])`         | yii\base\Controller | 渲染file。==根本方法== |
| `renderAjax($view, $params = [])`         | yii\web\Controller  | ajax渲染view           |

###### (I)、view怎么传值？支持以下：

>
>
> * `renderFile()`仅支持绝对路径
>
>* 其他都不支持绝对路径。绝对路径会被当作string
>
> 
>
> `frontend\controllers\SiteController::actionIndex()`

>|            | 方式     | 解释                                         | 举例                                          | 对应路径                                                     |
>| ---------- | -------- | -------------------------------------------- | --------------------------------------------- | ------------------------------------------------------------ |
>|            | 绝对路径 | 起始目录是服务器根目录                       | `render('c:\code\index.php')`                 | ==仅renderFile()支持==，其他会被当作string                   |
>|            | 相对路径 | 起始目录是：<br>app/module/views/controller/ | `render('../index')`                          | app/frontend/views/site/../index.php                         |
>| 任意跨     | 别名@    | @路径+string                                 | `render('@frontend/index')`                   | app/frontend/index.php                                       |
>|            | //       | app/+string                                  |                                               |                                                              |
>| 跨控制器   | /        | app/module/views/+string                     | `render('/index')`<br>`render('/site/index')` | app/frontend/views/index.php<br>app/frontend/views/site/index.php |
>| 当前控制器 | string   | app/module/views/controller/+string          | `render('index')`                             | app/frontend/views/site/index.php                            |



###### (II)、找view文件

>源码分析：yii\base\View
>
>```php
>protected function findViewFile($view, $context = null)
>{
>if (strncmp($view, '@', 1) === 0) {
>   // e.g. "@app/views/main"
>   $file = Yii::getAlias($view);
>} elseif (strncmp($view, '//', 2) === 0) {
>   // e.g. "//layouts/main"
>   $file = Yii::$app->getViewPath() . DIRECTORY_SEPARATOR . ltrim($view, '/');
>} elseif (strncmp($view, '/', 1) === 0) {
>   // e.g. "/site/index"
>   if (Yii::$app->controller !== null) {
>       $file = Yii::$app->controller->module->getViewPath() . DIRECTORY_SEPARATOR . ltrim($view, '/');
>   } else {
>       throw new InvalidCallException("Unable to locate view file for view '$view': no active controller.");
>   }
>} elseif ($context instanceof ViewContextInterface) {
>   $file = $context->getViewPath() . DIRECTORY_SEPARATOR . $view;
>} elseif (($currentViewFile = $this->getRequestedViewFile()) !== false) {
>   $file = dirname($currentViewFile) . DIRECTORY_SEPARATOR . $view;
>} else {
>   throw new InvalidCallException("Unable to resolve view file for view '$view': no active view context.");
>}
>
>if (pathinfo($file, PATHINFO_EXTENSION) !== '') {
>   return $file;
>}
>$path = $file . '.' . $this->defaultExtension;
>if ($this->defaultExtension !== 'php' && !is_file($path)) {
>   $path = $file . '.php';
>}
>
>return $path;
>}
>```
>



###### (III)、找到layout文件

* yii\base\Controller

>```PHP
>public function findLayoutFile($view)
>    {
>        $module = $this->module;
>        if (is_string($this->layout)) {
>            $layout = $this->layout;
>        } elseif ($this->layout === null) {
>            while ($module !== null && $module->layout === null) {
>                $module = $module->module;
>            }
>            if ($module !== null && is_string($module->layout)) {
>                $layout = $module->layout;
>            }
>        }
>
>        if (!isset($layout)) {
>            return false;
>        }
>
>        if (strncmp($layout, '@', 1) === 0) {
>            $file = Yii::getAlias($layout);
>        } elseif (strncmp($layout, '/', 1) === 0) {
>            $file = Yii::$app->getLayoutPath() . DIRECTORY_SEPARATOR . substr($layout, 1);
>        } else {
>            $file = $module->getLayoutPath() . DIRECTORY_SEPARATOR . $layout;
>        }
>
>        if (pathinfo($file, PATHINFO_EXTENSION) !== '') {
>            return $file;
>        }
>        $path = $file . '.' . $view->defaultExtension;
>        if ($view->defaultExtension !== 'php' && !is_file($path)) {
>            $path = $file . '.php';
>        }
>
>        return $path;
>    }
>```
>
>

##### b、跳转

| 方法                                | 物理位置           | 解释                 | 备注 |
| ----------------------------------- | ------------------ | -------------------- | ---- |
| `redirect($url, $statusCode = 302)` | yii\web\Controller |                      |      |
| `goHome()`                          | yii\web\Controller | 回到domain/index.php |      |
| `goBack($defaultUrl = null)`        | yii\web\Controller | 返回上一页           |      |
| `refresh($anchor = '')`             | yii\web\Controller | 刷新当前也           |      |

> `redirect($url, $statusCode)`
>
>* `$url`为数组：支持在当前模块中跳转。不能跨模块
>
>* `$url`为string：跳指定网站、或任意跳
>
>  ```php
>  //domain/index.php?r=site%2Findex2&id=12#ok
>  return $this->redirect(['site/index2', 'id'=>12,'#'=>'ok']);
>  
>  //domain/site/index2    （拼装好了可以任意跳）
>  return $this->redirect('site/index2');
>  //http://www.baidu.com
>  return $this->redirect('http://www.baidu.com');
>  ```
>
>  
>
> 
>
> 
>
>* yii\helpers\BaseUrl
>
>```php
>    protected static function normalizeRoute($route)
>    {
>        $route = Yii::getAlias((string) $route);
>        if (strncmp($route, '/', 1) === 0) {
>            // absolute route
>            return ltrim($route, '/');
>        }
>
>        // relative route
>        if (Yii::$app->controller === null) {
>            throw new InvalidArgumentException("Unable to resolve the relative route: $route. No active controller is available.");
>        }
>
>        if (strpos($route, '/') === false) {
>            // empty or an action ID
>            return $route === '' ? Yii::$app->controller->getRoute() : Yii::$app->controller->getUniqueId() . '/' . $route;
>        }
>
>        // relative to module
>        return ltrim(Yii::$app->controller->module->getUniqueId() . '/' . $route, '/');
>    }
>```
>
>

#### (3)、restfull-controller

参考文档：https://www.yiichina.com/tutorial/1606

* **yii\rest\Controller**

* **yii\rest\ActiveController** 资源的增删改查

  

  

#### (4)、功能

| 功能          | 第一次出现物理位置  | 注释            | 备注                                                    |
| ------------- | ------------------- | --------------- | ------------------------------------------------------- |
| `behaviors()` | yii\base\Component  | 行为            | yii\rest\Controller加了四个havior                       |
| `actions()`   | yii\base\Controller | 接口            | yii\rest\ActiveController添加了增删改查接口             |
| `verbs()`     | yii\rest\Controller | http method过滤 | 来源自   yii\rest\Controller::behaviors()中的verbFilter |

>verbs()的执行：触发behaviors()中的VerFilter过滤器
>
>actions()的执行：yii\base\Controller :: runAction()->createAction()->actions()
>
>behaviors()的执行：yii\base\Component::`attachBehaviorInternal($name, $behavior)`

>



## (四)、模型model

### 1、curd操作

#### (1)、增

##### a、增一

###### b、批量

#### (2)、删

#### (3)、改

#### (4)、查

### 2、where

**书写方式：**

* 1-字符串where(string)

* 2-数组where([k=>v])

* 3-参数where(K，v)

| 运算符分类 | 运算符                                            | 表达式          | 举例 |
| ---------- | ------------------------------------------------- | --------------- | ---- |
| 比较       | `=` `<>` ``!=`<br>`>` ` >=` `!>`<br>`<` `<=` `!<` | `!>=` `!<=` ??? |      |
| 范围       | `between...and`<br>`not between...and`            |                 |      |
| 列表       | `in` `not in`                                     |                 |      |
| 匹配       | `like` `not like`                                 |                 |      |
| null       | `is null` `is not null`                           |                 |      |
| 逻辑       | `and ||` `or &&` `not !` `xor`                    |                 |      |
| 正则       | `regexp`                                          |                 |      |
| 存在       | `exists`                                          |                 |      |



```sql
expr:
    expr OR expr
  | expr || expr
  | expr XOR expr
  | expr AND expr
  | expr && expr
  | NOT expr
  | ! expr
  | boolean_primary IS [NOT] {TRUE | FALSE | UNKNOWN}
  | boolean_primary

boolean_primary:
    boolean_primary IS [NOT] NULL
  | boolean_primary <=> predicate
  | boolean_primary comparison_operator predicate
  | boolean_primary comparison_operator {ALL | ANY} (subquery)
  | predicate

comparison_operator: = | >= | > | <= | < | <> | !=

predicate:
    bit_expr [NOT] IN (subquery)
  | bit_expr [NOT] IN (expr [, expr] ...)
  | bit_expr [NOT] BETWEEN bit_expr AND predicate
  | bit_expr SOUNDS LIKE bit_expr
  | bit_expr [NOT] LIKE simple_expr [ESCAPE simple_expr]
  | bit_expr [NOT] REGEXP bit_expr
  | bit_expr

bit_expr:
    bit_expr | bit_expr
  | bit_expr & bit_expr
  | bit_expr << bit_expr
  | bit_expr >> bit_expr
  | bit_expr + bit_expr
  | bit_expr - bit_expr
  | bit_expr * bit_expr
  | bit_expr / bit_expr
  | bit_expr DIV bit_expr
  | bit_expr MOD bit_expr
  | bit_expr % bit_expr
  | bit_expr ^ bit_expr
  | bit_expr + interval_expr
  | bit_expr - interval_expr
  | simple_expr

simple_expr:
    literal
  | identifier
  | function_call
  | simple_expr COLLATE collation_name
  | param_marker
  | variable
  | simple_expr || simple_expr
  | + simple_expr
  | - simple_expr
  | ~ simple_expr
  | ! simple_expr
  | BINARY simple_expr
  | (expr [, expr] ...)
  | ROW (expr, expr [, expr] ...)
  | (subquery)
  | EXISTS (subquery)
  | {identifier expr}
  | match_expr
  | case_expr
  | interval_expr
```







### 3、自动验证

### 4、自动完成

### 5、属性标签

### 6、数据导出？

## (五)、响应response

## (六)、缓存cache

## (七)、日志log



# 三、特色

## (一)、gii

# 四、功能

## (一)、session和cookie

## (二)、文件上传

## (三)、web和restfull

## (四)、图片验证

## (五)、发送邮件

## (六)、支持跨域请求

()、()、()、()、()、()、()、()、()、()、()、

# 五、源码分析

## 基类

### 1、yii\base\BaseObject

>* 属性
>
>```php
>class \yii\base\BaseObject implements \yii\base\Configurable
>{
>    //构造函数
>    public function __construct($config = []){$this->init();}
>    public function init(){}
>    //获取类名(后期静态绑定get_called_class)
>    public static function className(){};
>    
>    //属性(只读)
>    public function __get($name){}
>    public function __isset($name){}    
>    //属性(只写)
>    public function __set($name, $value){}         
>    public function __unset($name){}//并没有删除，只是把值设位null了
>	//是否有某个属性
>    public function hasProperty($name, $checkVars = true){}
>    //是否有某个只读属性
>    public function canGetProperty($name, $checkVars = true){}
>    //是否有某个只写属性
>    public function canSetProperty($name, $checkVars = true){}
>    
>    //抛出UnknownMethodException
>    public function __call($name, $params){}
>    //判断method是否存在
>    public function hasMethod($name){}//method_exists
>}
>
>```



属性分为 ：set/get开头的+成员变量(直接声明定义的)

`$checkVars = true`把成员变量也作为属性

#### (1)、只读属性

>```php
>//从当前class获取只读属性 
>public function __get($name)
> {
>     $getter = 'get' . $name;
>     if (method_exists($this, $getter)) {
>         return $this->$getter();
>     } elseif (method_exists($this, 'set' . $name)) {
>         throw new InvalidCallException('Getting write-only property: ' . get_class($this) . '::' . $name);
>     }
>
>     throw new UnknownPropertyException('Getting unknown property: ' . get_class($this) . '::' . $name);
> }
>//判断变量是不是只读属性
>public function __isset($name)
>{
>    $getter = 'get' . $name;
>    if (method_exists($this, $getter)) {
>        return $this->$getter() !== null;
>    }
>    return false;
>}
>
>//判断变量是不是只读属性或成员变量
>public function canGetProperty($name, $checkVars = true)
>{
>    return method_exists($this, 'get' . $name) || $checkVars && property_exists($this, $name);
>}
>
>```
>
>

#### (2)、只写属性

> ```php
> //赋值只写属性
> public function __set($name, $value)
> {
>     $setter = 'set' . $name;
>     if (method_exists($this, $setter)) {
>         $this->$setter($value);
>     } elseif (method_exists($this, 'get' . $name)) {
>         throw new InvalidCallException('Setting read-only property: ' . get_class($this) . '::' . $name);
>     } else {
>         throw new UnknownPropertyException('Setting unknown property: ' . get_class($this) . '::' . $name);
>     }
> }
> //删除只写属性
> public function __unset($name)
> {
>     $setter = 'set' . $name;
>     if (method_exists($this, $setter)) {
>         $this->$setter(null);
>     } elseif (method_exists($this, 'get' . $name)) {
>         throw new InvalidCallException('Unsetting read-only property: ' . get_class($this) . '::' . $name);
>     }
> }
> //判断变量是不是只写属性或成员变量
> public function canSetProperty($name, $checkVars = true)
> {
>     return method_exists($this, 'set' . $name) || $checkVars && property_exists($this, $name);
> }
> ```
>
> 

### 2、yii\base\Component

>* 属性
>* event
>* behavior
>
>```php
>class \yii\base\Component extends \yii\base\BaseObject
>{
>    private $_events = [];//常规event     name => event
>    private $_eventWildcards = [];//存放通配符event    通配符 =>event
>    private $_behaviors;//存放绑定的behaviors
>
>    //从当前class或behaviors中获取只读属性
>    public function __get($name);
>    public function __set($name, $value);
>    
>     //从当前class或behaviors中改写只写属性
>    public function __isset($name);
>    public function __unset($name);
>    //从class和behaviors中判断属性是否存在
>    public function hasProperty($name, $checkVars = true, $checkBehaviors = true);
>    public function canGetProperty($name, $checkVars = true, $checkBehaviors = true);
>    public function canSetProperty($name, $checkVars = true, $checkBehaviors = true);
>
>    public function __clone();
>    //调用class中或behaviors中的方法
>    public function __call($name, $params);
>    //判断class中或behaviors中是否有method
>    public function hasMethod($name, $checkBehaviors = true);
>    
>    
>	//event    
>    public function hasEventHandlers($name);//是否注册了name的event
>    public function on($name, $handler, $data = null, $append = true);    //注册event
>    public function off($name, $handler = null);//删除event
>    public function trigger($name, Event $event = null);    //触发event
>   
>    //behaviors
>    public function behaviors();//定义behaviors  此处return []
>
>    public function ensureBehaviors();//确认behaviors()都在$_behaviors中
>    public function attachBehavior($name, $behavior);//把behavior注册到$_behaviors
>    public function attachBehaviors($behaviors);//把behaviors注册到$_behaviors
>    private function attachBehaviorInternal($name, $behavior)//把$behavior存入$_behaviors中(根本之法)
>    public function getBehavior($name);//获取behavior
>    public function getBehaviors();//获取全部behaviors
>    public function detachBehavior($name);//删除behavior
>    public function detachBehaviors();//删除全部behaviors
>        
>}
>```
>
>













## (三)、controller

| 分类                      | 父类                | 功能     | 备注 |
| ------------------------- | ------------------- | -------- | ---- |
| yii\base\Controller       | yii\base\Component  |          |      |
| yii\console\Controller    | yii\base\Controller | cli指令  |      |
| yii\web\Controller        | yii\base\Controller | 渲染输出 |      |
| yii\rest\Controller       | yii\web\Controller  | api接口  |      |
| yii\rest\ActiveController | yii\rest\Controller |          |      |

#### (1)、yii\base\Controller

>`http://yii2.frame/frontend/web/index.php?r=hello-world/say-hello&sql=dfsfdsf`
>
>```php
>class \yii\base\Controller extends \yii\base\Component implements \yii\base\ViewContextInterface
>{
>const EVENT_BEFORE_ACTION = 'beforeAction';
>const EVENT_AFTER_ACTION = 'afterAction';
>
>@property Module[] $modules
>@property string $route
>@property string $uniqueId
>@property View|\yii\web\View $view
>@property string $viewPath
>
>public $module;//yii\base\Module  当前模块对象
>public $id;//string   controllerID
>public $action;//yii\base\Action    当前action对象
>
>public $request = 'request';//yii\base\Request    request对象
>public $response = 'response';//yii\base\Response  response对象
>
>public $defaultAction = 'index';//string
>public $layout;//null|string|false  默认主题
>private $_view;//yii\base\View
>private $_viewPath;//string
>//构造函数
>public function __construct($id, $module, $config = []){}
>public function init(){}
>    
>//runAction()->createAction()->actions()
>public function actions(){}//定义接口  次数 return []; 
>    
>//运行action
>public function runAction($id, $params = []){}
>public function run($route, $params = []){}
>public function bindActionParams($action, $params){}
>public function createAction($id){}
>//前置和后置操作
>public function beforeAction($action){}
>public function afterAction($action, $result){}
>//模块、控制器、路由
>public function getModules(){}
>public function getUniqueId(){}
>public function getRoute(){}
>//view
>public function render($view, $params = []){}
>public function renderContent($content){}
>public function renderPartial($view, $params = []){}
>public function renderFile($file, $params = []){}
>public function getView(){}
>public function setView($view){}
>public function getViewPath(){}
>public function setViewPath($path){}
>public function findLayoutFile($view){}
>
>final protected function bindInjectedParams(\ReflectionType $type, $name, &$args, &$requestedParams){}
>}
>```



#### (2)、yii\web\Controller

>
>
>```php
>class \yii\web\Controller extends \yii\base\Controller{
>    public $enableCsrfValidation = true;
>    public $actionParams = [];
>    
>    public function renderAjax($view, $params = []){}
>    public function bindActionParams($action, $params){}
>    public function beforeAction($action){}
>    //响应数据格式
>    public function asJson($data){}
>    public function asXml($data){}
>    //跳转
>    public function redirect($url, $statusCode = 302){}
>    public function goHome(){}
>    public function goBack($defaultUrl = null){}
>    public function refresh($anchor = ''){}
>}
>```
>
>18090306878

#### (3)、yii\rest\Controller

>
>
>```php
>class \yii\restController extends \yii\web\Controller
>{
>    public $serializer = 'yii\rest\Serializer';
>    public $enableCsrfValidation = false;
>    //绑定haviors
>    public function behaviors(){}
>    //后置操作把result序列化
>    public function afterAction($action, $result){}
>    protected function verbs(){}
>    protected function serializeData($data){}
>}
>```
>
> 
>
> 
>
>```php
>
>public function behaviors()
>{
>    return [
>        'contentNegotiator' => [//响应协商行为
>            'class' => ContentNegotiator::className(),
>            'formats' => [
>                'application/json' => Response::FORMAT_JSON,
>                'application/xml' => Response::FORMAT_XML,
>            ],
>        ],
>        'verbFilter' => [//
>            'class' => VerbFilter::className(),
>            'actions' => $this->verbs(),
>        ],
>        'authenticator' => [
>            'class' => CompositeAuth::className(),
>        ],
>        'rateLimiter' => [
>            'class' => RateLimiter::className(),
>        ],
>    ];
>}
>
>public function afterAction($action, $result)
>{
>    $result = parent::afterAction($action, $result);
>    return $this->serializeData($result);
>}
>
>protected function verbs()
>{
>    return [];
>}
>
>
>protected function serializeData($data)
>{
>    return Yii::createObject($this->serializer)->serialize($data);
>}
>```
>
>







#### (4)、yii\rest\ActiveController

>
>
>```php
>class \yii\rest\ActiveController extends \yii\rest\Controller
>{
>    public $modelClass;
>    public $updateScenario = Model::SCENARIO_DEFAULT;
>    public $createScenario = Model::SCENARIO_DEFAULT;
>    //初始化强制验证modelClass
>    public function init(){}
>    public function actions(){}//yii\base\Controller
>    protected function verbs(){}//yii\rest\Controller
>    public function checkAccess($action, $model = null, $params = []){}
>}
>```
>
> 
>
> 
>
>```php
>public function init()
>{
>    parent::init();
>    if ($this->modelClass === null) {
>        throw new InvalidConfigException('The "modelClass" property must be set.');
>    }
>}
>//增删改查
>public function actions()
>{
>    return [
>        'index' => [
>            'class' => 'yii\rest\IndexAction',
>            'modelClass' => $this->modelClass,
>            'checkAccess' => [$this, 'checkAccess'],
>        ],
>        'view' => [
>            'class' => 'yii\rest\ViewAction',
>            'modelClass' => $this->modelClass,
>            'checkAccess' => [$this, 'checkAccess'],
>        ],
>        'create' => [
>            'class' => 'yii\rest\CreateAction',
>            'modelClass' => $this->modelClass,
>            'checkAccess' => [$this, 'checkAccess'],
>            'scenario' => $this->createScenario,
>        ],
>        'update' => [
>            'class' => 'yii\rest\UpdateAction',
>            'modelClass' => $this->modelClass,
>            'checkAccess' => [$this, 'checkAccess'],
>            'scenario' => $this->updateScenario,
>        ],
>        'delete' => [
>            'class' => 'yii\rest\DeleteAction',
>            'modelClass' => $this->modelClass,
>            'checkAccess' => [$this, 'checkAccess'],
>        ],
>        'options' => [
>            'class' => 'yii\rest\OptionsAction',
>        ],
>    ];
>}
>
>
>protected function verbs()
>{
>    return [
>        'index' => ['GET', 'HEAD'],
>        'view' => ['GET', 'HEAD'],
>        'create' => ['POST'],
>        'update' => ['PUT', 'PATCH'],
>        'delete' => ['DELETE'],
>    ];
>}
>
>    public function checkAccess($action, $model = null, $params = [])
>    {
>    }
>```
>
>







