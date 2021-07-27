# 一、入门须知

扩展的全部都写在这里

在代码前写文件路径

index.php

./flancklin/session/SessionHelper.php

>```php
><?
>namespace flancklin\session;
>
>class SessionHelper {.....}
>```

8.3

* 过完对象语法
* session自定义
* 文件上传
* 数学精度计算

8.4

* http请求，get/post  https
* 认证

8.5

* 发邮件
* 发验证图片，(闪动的如何搞？)

## (一)、hello world

==index.php==

>相关格式要求：
>
>* 文件格式，以.php结尾。比如：index.php
>
>* 文件内部格式：`<?php ..代码..?>`，后面的`?>`可省略
>
>* 支持单行注释和多行注释
>
>* 结束标志是：分号`;`。比如：`$var=1;  $var2=2;`
>
>  
>
>在linux的cli中运行   php index.php
>
>==<?php ..... ?\>==是文件开始和结束标志，开始标志必须有，结束标志可以省略
>
>* php.ini中short_open_tag改为短标签(缩写)\<? ?\>
>* php.ini中asp_tags改为asp风格 <% %>==PHP 7.0.0. 中移除。==
>
>```php
><?php
>    //这是单行注释
>    /**
>    多行
>    注释
>  	*/
>    
>/*变量*******************************************/    
>    $var = '';           //声明定义、初始化赋值
>	$var = 'hello world';//第二次赋值
>	echo $var;           //变量调用
>
>/*function*******************************************/
>	function myFun(){    //function声明定义
>        $var  = 'hello world22';
>        return $var;
>    }
>	echo myFun();        //function调用
>
>/*对象(类)*******************************************/
>	class MyClass{       //对象(类)声明定义
>        public $var = "hello world333"; //类变量  
>        public function myFun2(){       //类function
>            return $this->var;
>        }
>    }
>	$obj = new MyClass();//实例化对象 
>	echo $obj->myFun2(); //调用对象function
>	
>```



## (二)、文档文献

>**官方**
>
>* 在线中文：https://www.php.net/manual/zh/index.php
>
>* chm下载：https://www.php.net/download-docs.php

## (三)、注释

### 单行注释

>* 双斜杠 //
>  * 快捷键 【ctrl】+【?/】   
>  * 加注释和去掉注释都是这个
>  * phpstorm应用
>
>```php
>//我是注释
>```

### 多行注释

>
>
>* /* ..... */
>  * 快捷键   【ctrl】+ 【shift】+【?/】
>  * 加注释和去掉注释都是这个
>  * phpstorm应用
>
>```php
>/**
>我是注释
>*/
>```

## (四)、转义字符

>反斜杠 \

## (五)、调试

# 二、语法

## (一)、数据类型

### 1、类型列表

>4种标量：boolean、integer、float、string
>
>3种复合：array、object、callback
>
>2种特殊：resource、NULL
>
>1种不是数据类型：NaN

| 序号 | 类型     | 举例                                             | 备注                                                         |
| ---- | -------- | ------------------------------------------------ | ------------------------------------------------------------ |
| 1    | boolean  | true\|false\|TRUE\|FALSE                         | 不区分大小写                                                 |
| 2    | integer  | -1\|0\|1                                         | 支持2/8/10/16进制<br>10转2进制：`decbin($var)`<br/>10转8进制：`decoct($var)`<br/>10转16进制：`dechex($var)`<br/>2转10进制：`bindec($var)`<br/>8转10进制：`octdec($var)`<br/>16转10进制：`hexdec($var)`<br/>任意进制转换：`base_convert($number, $from, $to)` |
| 3    | float    | -1.0\|0.0\|1.0                                   |                                                              |
| 4    | string   | '123'\|'abcd'\|heredoc\|nowdoc                   | [string](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html) 最大可以达到 2GB。<br>==可以当作array进行字符修改与获取== |
| 5    | null     | null\|NULL                                       | 仅定义默认为null；<br>变量被unset()<br>==都会有警告提示 PHP Notice== |
| 6    | array    | array(1,'1') \| [1,'1'] \| ['k'=>'v'] \| [['a']] | 多维数组/关联数组                                            |
| 7    | object   | new StdClass()                                   | new 类名                                                     |
| 8    | callback | function(){}                                     | 执行:$var(参数)或者call_user_func(\$var,\$params)            |
| 9    | resource | file_open('filename')                            | get_resource_type。某些文件或连接的句柄<br>文档附录：资源类型列表。有好几十中，比如：file，mysql，odbc，curl，fpt等 |

* ==array==中得元素可以是任意数据类型，包括array,object,callback都可以

* ==NAN==是个奇葩

>```php
>$var1=true;         //boolean
>$var2=1;            //integer
>$var3=1.23;         //float
>$var4='abcd';       //string 有四种定义方式
>$var5=null;         //null
>$var6=array(1,'1'); //array 有两种定义方式 array()和[]
>$var7= new stdClass();//object
>$var8=function(){return 5;}//callback
>$var9='';
>```

### 2、细说数据类型

#### (1)、integer和int的精度与溢出问题。

* 如果给定的一个数超出了 [integer](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html) 的范围，将会被解释为    [float](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)。

>```php
>$var = PHP_INT_MAX;
>var_dump($var);//int
>var_dump($var+1);//float
>$var= PHP_INT_MIN;
>var_dump($var);//int
>var_dump($var-1);//float
>```



#### (2)、string

##### a、字符串==可以当作array==进行修改和读取单个字符

>```php
>//(汉字在utf-8中占三位，这样读取会乱码)
>echo $var4[0];//结果为a;
>$var4[0]=1;
>echo $var4;//结果为1bc
>```

##### b、字符串的四种定义方法：

单引号-nowdoc和双引号-heredoc

* 单引号和nowdoc不支持解释变量，也不支持转义符(除了转义单引号)

>```php
>$var = 'string';
>$var = "string";
>$var=<<<'label'
>string
>label;
>$var=<<<label
>    string
>    label;
>```

##### c、关于nowdoc和heredoc

###### (I)、规则

* 只能包含字母、数字和下划线。不能以数字开头。
* 开始标志和结束标志必须单独占一行，且不算入字符串内容。
* 开始标志行、结束标志行不得有其他任何内容：包括空、注释等，有则出错。字符串内容出现注释，会被当作字符串
* 结束标志行只含有结束标志和[结束分号]，不论其前还是其后，哪怕多一个空格都是错
* 结束标志行不能是该文件的最后一行。(哪怕后面再空一行也不会报错)

###### (II)、错误举例

> ```php
> //标志命名错误。仅含数字、字母和下划线
> $var1=<<<label-1
> string
> label-1;
> //开始标志后面多了一个空格
> $var2=<<<label 
> string
> label;
> //结束标志行的逗号后面多了一个空格
> $var3=<<<lable
> string
> lable; 
> //开始标志行、结束标志行，不得有其他任何内容。包括空、注释等
> $var4=<<<label//我是注释
> string
> label;
> //结束标志行不可为当前文件的最后一行
> $var5=<<<label
> string
> label;
> ```



>这个是对的
>
>```php
>define('myConstant', <<<label
>string
>label
>);
>```

#### (3)、array

==array中key严格区分大小写==                    `['a'=>1] != ['A'=>2]`

==array中key数字和字符型数字完全等同== `[2 => 'a']===['2'=>'a']`

`array_unique([1,'1'])===['1']`

##### a、定义方式有两种

>```php
>$var = array(1,'a');
>$var = [1, 'a'];
>```

##### b、关联与非关联数组

>```php
>//非关联数组（索引数组）    key由0逐一递增
>$var = ['v1', 'v2'];//非关联数组   等同于 [0 =>'v1', 1=>'v2']
>//关联数组               key可为integer也可string也可混合
>$var = ['a' => 'v1', 'b' => 'v2'];//a|b称为key键名，v1|v2称为value键值。
>```
>
>关联数组key规则：
>
>* “8”=>8                      字符串整数自动转为整数。"08"不会转换
>
>* 8.7=>8                     浮点数将被取整
>
>* true|false=>1|0
>
>* null=>''
>
>* array|object         语法直接报警告 IIIegal offset type
>
>* 如果key在同一个array中重复了，最后一个有效，前面的被覆盖
>
>  ```php
>  $array = array(
>      1    => "a",
>      "1"  => "b",
>      1.5  => "c",
>      true => "d",
>  );//结果为[1=>'d']
>  ```

##### c、判断两个数组是否相同

>
>
>```php
>var_dump(['1'] == [1]);//true
>var_dump(['1'] === [1]);//false
>
>var_dump(['1'=>'a'] === [1=>'a']);//true
>
>var_dump(['1' =>2] == ['1' => '2']);//true
>var_dump(['1' =>2] === ['1' => '2']);//false
>```
>
>===会严格区分value的类型，而\==不会
>
>至于key，`[2 => 'a']===['2'=>'a']`，故没有顾虑的

##### c、把object强转化为array

>```php
>class Base {
>	public $ba= 'ba';
>	private $bb = 'bb';
>	protected $bc = 'bc';
>	
>	public static $bsa = 'bsa';
>	private static $bsb = 'bsb';
>	protected static $bsc = 'bsc';
>
>}
>class MyClass extends Base{
>	public $a= 'a';
>	private $b = 'b';
>	protected $c = 'c';
>	
>	public static $sa = 'sa';
>	private static $sb = 'sb';
>	protected static $sc = 'sc';
>}
>$var = new MyClass();
>var_dump((array)$var);
>/*
>array(6) {
> ["a"]=>           //self-public     是：变量名作为key
> string(1) "a"
> ["MyClassb"]=>    //self-private    是：[null+类名+null+变量]名作为key
> string(1) "b"
> ["*c"]=>          //self-protected  是:[null+*+null+变量名]作为key
> string(1) "c"
> ["ba"]=>          //parent-public   是：变量名作为key
> string(2) "ba"
> ["Basebb"]=>      //parent-private 是：[null+父类名+null+变量]名作为key
> string(2) "bb"
> ["*bc"]=>         //parent-protected是：[null+*+null+变量名]作为key
> string(2) "bc"
>}
>*/
>```
>
>键名将为成员变量名，不过有几点例外：<br>整数属性不可访问；<br>私有变量前会加上类名作前缀；<br>保护变量前会加上一个    '*' 做前缀。<br>
>
>==这些前缀的前后都各有一个 NULL 字符。这会导致一些不可预知的行为==

#### (4)、resource

释放资源

   引用计数系统是 Zend 引擎的一部分，可以自动检测到一个资源不再被引用了（和     Java 一样）。这种情况下此资源使用的所有外部资源都会被垃圾回收系统释放。因此，很少需要手工释放内存。   

> ==Note==:     持久数据库连接比较特殊，它们*不会*被垃圾回收系统销毁。参见[数据库永久连接](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/features.persistent-connections.html)一章。    



### 3、类型强转换



| 序号 | 类型     | 强转换                     | 备注                                                         |
| ---- | -------- | -------------------------- | ------------------------------------------------------------ |
| 1    | boolean  | (bool)\|(boolean)          | 当转换为 [boolean](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html) 时，以下值被认为是 **`FALSE`**：   <br>[布尔](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html)值 **`FALSE`** 本身<br/>[整型](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html)值 0（零）<br/>[浮点型](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)值 0.0（零）<br/>空[字符串](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html)，以及[字符串](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html) "0"  <br/>不包括任何元素的[数组](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.array.html)<br/>特殊类型 [NULL](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.null.html)（包括尚未赋值的变量）<br/>从空标记生成的 [SimpleXML](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/ref.simplexml.html) 对象<br>所有其它值都被认为是 **`TRUE`**（==包括任何[资源](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 和  **`NAN`**==）。 |
| 2    | integer  | (int)\|(integer)\|intval() | 从boolen转换：false-0,true-1<br>从float转换：向下取整<br>NaN和Infinity转换：0     （==php7.0.0==）<br>从string转换：以数字(含科学计数)开头则数字，其他为0<br>将 [resource](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 转换成 [integer](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html) 时，   结果会是 PHP 运行时为 [resource](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 分配的唯一资源号。<br>==没有定义从其它类型转换为整型的行为。*不要*依赖任何现有的行为，因为它会未加通知地改变== |
| 3    | float    |                            |                                                              |
| 4    | string   | (string)\|strval()         | 从boolean值转换：false-0,true-1<br>从integer和float转换：对应字符串<br>从array转换：‘Array’字样<br>从object转换：‘Object’字样<br>从resource转换：‘Resource id #1'字样<br>从null转换：空字符串 |
| 5    | null     |                            |                                                              |
| 6    | array    | (array)\|array($var)       | 对于任意 [integer](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html)，[float](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)，[string](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html)，[boolean](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html)    和 [resource](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 类型转为array，将得到一个只有一个元素的数组<br>将 **`NULL`** 转换为 [array](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.array.html) 会得到一个空的数组<br>降object转为array：属性名为key，属性值为value |
| 7    | object   |                            | 如果其它任何类型的值被转换成对象，将会创建一个内置类    *stdClass* 的实例。<br>如果该值为    **`NULL`**，则新的实例为空。 <br>   [array](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.types.array.html) 转换成 [object](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.types.object.html) 将使键名成为属性名并具有相对应的值。<br>注意：在这个例子里， 使用 PHP 7.2.0 之前的版本，数字键只能通过迭代访问。 |
| 8    | callback |                            |                                                              |
| 9    | resource |                            | 无意义                                                       |



### 4、数据类型的相关常量

| 序号 | 类型     | 相关常量                                                     |
| ---- | -------- | ------------------------------------------------------------ |
| 1    | boolean  |                                                              |
| 2    | integer  | PHP_INT_MAX  最大整数<br>PHP_INT_MIN  最小整数（==php7.0.0==）<br>PHP_INT_SIZE  int型占字节数 |
| 3    | float    | PHP_FLOAT_DIG  最大不损精度的小数位数（==php7.2.0==）<br>PHP_FLOAT_EPSILON（==php7.2.0==）<br/>PHP_FLOAT_MIN（==php7.2.0==）<br/>PHP_FLOAT_MAX（==php7.2.0==） |
| 4    | string   |                                                              |
| 5    | null     |                                                              |
| 6    | array    |                                                              |
| 7    | object   |                                                              |
| 8    | callback |                                                              |
| 9    | resource |                                                              |

#### 

## (二)、变量和常量(都区分大小写)

| 载体名称 | 大小写   | 举例                         | 备注         |
| -------- | -------- | ---------------------------- | ------------ |
| 变量     | 严格区分 | `$var='v1';`<br>`$vaR='v2';` |              |
| 常量     | 严格区分 | `define("FOO","vvv");`       | 习惯统一大写 |

### 1、变量

#### (1)、命名规则

>`[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*`    ==`$this`==这是一个特殊

==区分大小写==

#### (2)、声明定义和初始化

> ​	百无禁忌，什么值都可拿来初始化变量。至少当前如此
>
> ```php
> $a;                    //不初始化，默认是null
> $a = null;             //null类型
> $a = false;            //boolean类型
> $a = 100;              //integer类型
> $a = 100.23;           //float类型
> $a = ['a' => 'a'];     //array类型
> $a = PHP_VERSION;      //调用已定义的常量
> $a = "abcd";           //string类型
> //string的nowdoc
> $a = <<<'label'
> abcd
> label;
> //string的heredoc
> $a=<<<label
> abcd
> label;
> $a = 1+2;              //简单的数学运算，支持加/减/乘/除/求模/求幂
> $a = bcadd(1,2);       //掉函数
> $a = function(){return 5;};//callback
> $a = new stdClass();       //object  
> ```
>
> 

#### (4)、特殊变量

##### a、预定义变量

| 序号 | 命令名称                | 分类         | 作用                            | 其他                                                         |
| ---- | ----------------------- | ------------ | ------------------------------- | ------------------------------------------------------------ |
| 1    | `$GLOBALS`              | 超全局变量   | 全局作用域的可用全部变量        |                                                              |
| 2    | `$_ENV`                 | 超全局变量-E | shell环境变量                   | 由shell提供                                                  |
| 3    | `$_SERVER`              | 超全局变量-S | web服务器和执行环境信息         | 由web服务器提供                                              |
| 4    | `$_REQUEST`             | 超全局变量   | `$_GET` + `$_POST` + `$_COOKIE` | php.ini的request_order="GPC"                                 |
| 5    | `$_GET`                 | 超全局变量-G | http-get                        |                                                              |
| 6    | `$_POST`                | 超全局变量-P | http-post                       |                                                              |
| 7    | `$_COOKIE`              | 超全局变量-C | cookie值                        |                                                              |
| 8    | `$_SESSION`             | 超全局变量   | session                         | 必须开启session才有这个变量。<br>否则报未定义。详细看session扩展 |
| 9    | `$_FILES`               | 超全局变量   | http上传文件                    |                                                              |
| 10   | `$php_errormsg`         |              | 前一个错误信息                  | ==7.2.0删==                                                  |
| 11   | `$HTTP_RAW_POST_DATA`   |              | 原生post数据                    | ==5.6.0删==                                                  |
| 12   | `$http_response_header` |              | http响应头(局部作用域)          | 注意报错：未定义变量                                         |
| 13   | `$argc`                 |              | 传递给脚本的参数个数            | php.ini的register_argc_argv                                  |
| 14   | `$argv`                 |              | 传递给脚本的参数数组            |                                                              |

* ==超全局变量意味着它们在一个脚本的全部作用域中都可以被调用==
* 奇葩：`$GLOBALS['GLOBALS']['GLOBALS']['GLOBALS']`和`$GLOBALS`完全一样，而且不是错
* `$GLOBALS`中包含了全部的超全局变量(9种，包括它自己)
* php.ini中==variables_order==控制`$_ENV` `$_GET` `$_POST` `$_COOKIE` `$_SERVER`是否为空。EGPCS<br>正式环境建议`$_ENV`设为空，需要的时候使用getenv()调用

###### (I)、`$_GLOBALS`

>必定包含9个超全局变量，含自己

往globals中塞数

>```php
>global $varxxx;//这里只有声明，不准初始化赋值
>$varxxx= 'xxx';
>
>var_dump($GLOBALS);
>var_dump($GLOBALS['varxxx']);//xxx
>```

###### (||)、`$_ENV`

>具体包含哪些值。由运行环境中的shell提供。不同shell，提供的列表值不同。

|字段|含义|举例|备注|

###### (III)、`$_SERVER`

>==具体值列表依web服务器及其配置而定==
>
>举例：http://lcs.ca.com/index.php/test/a?p1=1&p2=2

| 分类      | 字段              | 含义            | 举例                   | 备注              |
| --------- | ----------------- | --------------- | ---------------------- | ----------------- |
| url       | REQUEST_SCHEME    | web协议         | http                   |                   |
|           | HTTPS             | 是否开启https   | on                     |                   |
|           | REQUEST_METHOD    | 请求方式        | GET                    |                   |
|           | HTTP_HOST         | 域名            | lcs.ca.com             |                   |
|           | PHP_SELF          | 文件名          | /index.php             |                   |
|           | REQUEST_URI       |                 | /index.php/test/a?p1=1 |                   |
|           | QUERY_STRING      | get参数         | p1=1&p2=2              |                   |
| 协议      | GATEWAY_INTERFACE | CGI版本         | CGI/1.1                |                   |
|           | SERVER_PROTOCOL   | http版本        | HTTP/1.1               |                   |
| web服务器 | SERVER_NAME       | 主机名          | lcs.ca.com             | web服务器中配置的 |
|           | DOCUMENT_ROOT     | web.config.root | index.php的绝对路径    |                   |
|           | SERVER_SOFTWARE   | web服务器       | nginx/apache           |                   |
| 浏览器    | HTTP_USER_AGENT   | 浏览器型号      |                        |                   |

###### (IV)、`$http_response_header `

>具有较强的==局部==作用域
>
>```php
>function get_contents() {
>file_get_contents("http://example.com");
>var_dump($http_response_header);//有值
>}
>get_contents();
>var_dump($http_response_header);//null  这里会报错，提示未定义
>```
>
>



##### b、可变变量

>即变量的名称是可变的变量
>
>```php
>$a = 'var';
>$$a = 'value';
>echo $var;//value
>```
>
>

##### c、静态变量static

###### (I)、静态变量的加载规则

>静态变量存在其作用域，不是任意地方定义全局使用。比如：函数内的`static $a`和函数外的`static $a`，在定义值和取值时都没有歧义
>
>static是怎么运行的？
>
>* 为什么函数外的`static $a`是999，不是在die后面吗？
>* 为什么函数内的`static $a`是30起步，`if(false)`不会执行的啊？
>* * static的定义和初始化并不是按php语法规则来的      ==静态声明是在编译时解析的==
>* * 推测是按文件的加载过程来的。当加载文件的时候，逐行扫描，遇到static，则放在对应的堆栈/hash中。比如这个文件,假设用hash
>  * 开始扫描文件
>  * 1、第1行的`static $a`，==函数外==，ash中不存在，存入hash。最终hash值：['a' => 100]
>  * 2、第3行的`static $a`，==函数内==，在hash中也不存在，存入hash。最终hash值：['a' => 100, 'myFun.a' => 1]
>  * 3、第5行的`static $a`，==函数内==，在hash中存在，更新hash中的值。最终hash值：['a' => 100, 'myFun.a' => 20]
>  * 4、第8行的`static $a`，==函数内==，在hash中存在，更新hash中的值。最终hash值：['a' => 100, 'myFun.a' => 30]
>  * 5、第18行的`static $a`，==函数外==，在hash中存在，更新hash中的值。最终hash值：['a' => 110, 'myFun.a' => 30]
>  * 6、第20行的`static $a`，==函数外==，在hash中存在，更新hash中的值。最终hash值：['a' => 999, 'myFun.a' => 30]
>  * 该文件扫描完成，继续下一个文件。继续存入hash中，或更新hash中的值。知道整个文件系统加载完。
>  * 这里为什么有 a和myfun.a，这个是作用域的效果。如果是类的静态属性，则是namespace.className.变量名
>
>```php
>static $a = 100;
>function myFun(){
>  static $a = 1;
>  if($a > 2){
>      static $a = 20;
>  }
>  if(false){
>      static $a = 30;
>  }
>  var_dump($a);
>  ++$a;
>}
>var_dump($a);//999
>myFun();//30
>myFun();//31
>var_dump($a);//999
>
>static $a=110;
>die;
>static $a=999;
>```
>
>

###### (II)、静态变量的初始化

>正确的初始化举例
>
>* ```php
>  static $a;                    //不初始化，默认是null
>   static $a = null;             //null类型   
>   static $a = false;            //boolean类型
>   static $a = 100;              //integer类型
>   static $a = 100.23;           //float类型
>   static $a = ['a' => 'a'];     //array类型
>   static $a = PHP_VERSION;      //调用已定义的常量
>   static $a = "abcd";           //string类型
>   //string的nowdoc
>   static $a = <<<'label'
>   abcd
>   label;
>   //string的heredoc
>   static $a=<<<label
>   abcd
>   label;
>   static $a = 1+2;              //简单的数学运算，支持加/减/乘/除/求模/求幂
>  ```
>  ```
>
> ```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>
>
>```
>错误的初始化举例
>
>* ```php
> static $a = bcadd(1,2);                 //不可以调用函数
> static $a = function(){echo 'hello!';}  //不可以callback
> static $a = new stdClass();             //不可以object
>```
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```
>
>```

### 2、常量

#### (1)、命名规则

>`[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*`
>
>* ==区分大小写==      习惯常量标识全部大写，比如：`define("PHP_INT_MAX", 222)`
>
>* ==同一个常量只能被定义一次==
>
>* ==常量一旦定义，不能修改其值。==  没法修改值，没法删除常量



>```php
>define('myConstant', 100);
>define('myConstant', 88);//报错
>myConstant=99;//报错
>```
>
>

#### (2)、声明定义和初始化

##### (a)、define和const定义的常量，是同一个东西吗？

>```php
>const myConstant = 100;
>define('myConstant', 100);//报错，说重复定义了
>```
>
>* define和const定义的常量，是同一东西

##### (b)、define和const用哪个好？

| 情况   | define    | const    |
| ------ | --------- | -------- |
| array  | 7.0才支持 | 一直支持 |
| 调函数 | 一直支持  | 不支持   |

>* 综上给出建议：
>* * 对象之内用const
> * 对象之外用define

#### (3)、特殊常量(魔术常量)

>结果值都是根据==魔术常量在代码的物理存储位置==决定的，与继承、引入文件、解释编译等无关
>
>日志log记录原理是利用了函数debug_backtrace 
>
>==魔术变量==不区分大小写

| 常量名称        | 作用                  | 其他                      |
| --------------- | --------------------- | ------------------------- |
| `__LINE__`      | 文件中当前行号        | 8                         |
| `__FILE__`      | 所在文件(含路径)      | C:\code\c.php             |
| `__DIR__`       | 所在目录              | C:\code                   |
| `__FUNCTION__`  | 所在函数/方法         | getFunction               |
| `__CLASS__`     | 所在类(带命名空间)    | ttttt\sssss\Aa            |
| `__TEAIT__`     | 所在trait(带命名空间) |                           |
| `__METHOD__`    | 所在方法(带命名空间)  | ttttt\sssss\Bb::getMethod |
| `__NAMESPACE__` | 所在空间              | ttttt\sssss               |

## (三)、运算符

### 运算符优先级

| 结合方向 | 优先级 | 运算符                                                       | 附加信息                                                     |
| -------- | ------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 无       | 1      | clone new                                                    | [clone](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.oop5.cloning.html) 和 [new](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.oop5.basic.html#language.oop5.basic.new) |
| 右       | 2      | \*\*                                                         | [算术运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.arithmetic.html) |
| 右       | 3      | *++*          *--*          *~*          *(int)*          *(float)*   <br>    *(string)*          *(array)*          *(object)*          *(bool)*          *@* | [类型](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.types.html)、[递增／递减](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.increment.html)、[错误控制](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.errorcontrol.html) |
| 无       | 4      | *instanceof*                                                 | [类型](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.types.html) |
| 右       | 5      | *!*                                                          | [逻辑运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.logical.html) |
| 左       | 6      | *          */*          *%*                                  | [算术运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.arithmetic.html) |
| 左       | 7      | *+*          *-*          *.*                                | [算术运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.arithmetic.html) 和 [字符串运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.string.html) |
| 左       | 8      | *<<*          *>>*                                           | [位运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.bitwise.html) |
| 无       | 9      | *<*          *<=*          *>*          *>=*                 | [比较运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.comparison.html) |
| 无       | 10     | *==*          *!=*          *===*          *!==*          *<>*          *<=>* | [比较运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.comparison.html) |
| 左       | 11     | *&*                                                          | [位运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.bitwise.html) 和 [引用](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.references.html) |
| 左       | 12     | *^*                                                          | [位运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.bitwise.html) |
| 左       | 13     | *\|*                                                         | [位运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.bitwise.html) |
| 左       | 14     | *&&*                                                         | [逻辑运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.logical.html) |
| 左       | 15     | *\|\|*                                                       | [逻辑运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.logical.html) |
| 右       | 16     | *??*                                                         | [null 合并运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.comparison.html#language.operators.comparison.coalesce) |
| 左       | 17     | *? :*                                                        | [三元运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.comparison.html#language.operators.comparison.ternary) |
| 右       | 18     | *=*          *+=*          *-=*          *\*=*          *\*\*=* <br>*/=*          *.=*          *%=*          *&=*          *\|=*  <br> *^=*          *<<=*          *>>=* | [赋值运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.assignment.html) |
| 右       | 19     | *yield from*                                                 | [yield from](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.generators.syntax.html#control-structures.yield.from) |
| 右       | 20     | *yield*                                                      | [yield](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.generators.syntax.html#control-structures.yield) |
| 左       | 21     | *and*                                                        | [逻辑运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.logical.html) |
| 左       | 22     | *xor*                                                        | [逻辑运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.logical.html) |
| 左       | 23     | *or*                                                         | [逻辑运算符](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.operators.logical.html) |

### 1、赋值运算符

>| 序号 | 符号 | 作用 | 举例    | 备注 |
>| ---- | ---- | ---- | ------- | ---- |
>| 1    | =    | 赋值 | `$x=1;` |      |

### 2、算术运算符

>```php
>//案例数据
>$x=4;$y=2;
>```
>
>| 序号 | 符号   | 作用       | 举例                                    | 备注                                            |
>| ---- | ------ | ---------- | --------------------------------------- | ----------------------------------------------- |
>| 1    | +      | 加法       | `$x+$y=6`                               |                                                 |
>| 2    | -      | 减法       | `$x-$y=2`                               |                                                 |
>| 3    | *      | 乘法       | `$x*$y=8`                               |                                                 |
>| 4    | /      | 除法       | `$x/$y=2`                               |                                                 |
>|      |        |            |                                         |                                                 |
>| 5    | -      | 取反(负号) | `-$x=-4`                                | `-2-2=-4`                                       |
>| 6    | %      | 取模(求余) | `$x%$y=0`                               |                                                 |
>| 7    | **     | 指数(求幂) | `$x**$y=16`                             |                                                 |
>|      |        |            |                                         |                                                 |
>| 8    | 不支持 | 整除       |                                         |                                                 |
>| 9    | ++     | 递增       | `echo ++$x;`输出5<br>`echo $x++;`输出4  | `++`在前，先+1再运算；<br>`++`在后，先运算再+1  |
>| 10   | --     | 递减       | `echo --$x;`输出3<br/>`echo $x--;`输出4 | `--`在前，先-1再运算；<br/>`--`在后，先运算再-1 |

>==递增递减不影响布尔值。递减 NULL 值也没有效果，但是递增 NULL 的结果是 1。==
>
>```php
>$a=true;
>var_dump(++$a);//true
>$a=true;
>var_dump(--$a);//true
>
>$a=null;
>var_dump(++$a);//1
>$a=null;
>var_dump(--$a);//null
>
>$a=null;
>var_dump($a++);//null
>var_dump($a);//1
>$a=null;
>var_dump($a--);//null
>var_dump($a);//null
>```
>
>

### 3、逻辑运算符

>| 序号 | 符号    | 作用 | 举例        | 备注                                     |
>| ---- | ------- | ---- | ----------- | ---------------------------------------- |
>| 1    | ！      | 非   |             |                                          |
>| 2    | and和&& | 与   |             |                                          |
>| 3    | or和ll  | 或   |             |                                          |
>| 4    | xor     | 异或 | `$a xor $b` | `$a`和`$b`有且只有一个为true，结果才true |
>|      |         |      |             |                                          |
>| 5    | 不支持  | 相等 |             |                                          |
>| 6    | 不支持  | 隐含 |             |                                          |

### 43、比较运算符(关系)

==文档>附录>php类型比较表==

| 序号 | 符号 | 作用     | 举例                                   | 备注                 |
| ---- | ---- | -------- | -------------------------------------- | -------------------- |
| 1    | ==   | 等于     | `(1=='1')=true`                        |                      |
| 2    | ===  | 全等     | `(1==='1')=false`                      |                      |
| 3    | !=   | 不等     | `(1!='1')=false`                       |                      |
| 4    | !==  | 不全等   | `(1!=='1')=true`                       |                      |
| 5    | <    | 小于     |                                        |                      |
| 6    | >    | 大于     |                                        |                      |
| 7    | <=   | 小于等于 |                                        |                      |
| 8    | \>=  | 大于等于 |                                        |                      |
| 9    | <=>  | 全比较   | `(3<=>1)=1` `(1<=>3)=-1 `  `(1<=>1)=0` | 用`==`且==php7.0.0== |

### 5、字符串运算符

>```php
>$a = 'a';
>$b = 'b';
>```

| 序号 | 符号 | 作用       | 举例                   | 备注                          |
| ---- | ---- | ---------- | ---------------------- | ----------------------------- |
| 1    | .    | 连接字符串 | `echo $a.$b;`输出ab    |                               |
| 2    | .=   | 连接字符串 | `echo $a .= $b;`输出ab | `$a.=$b`和`$b =$a.$b`完全相同 |

### 6、位运算符

| 序号 | 符号 | 作用                                  | 举例              | 备注                                               |
| ---- | ---- | ------------------------------------- | ----------------- | -------------------------------------------------- |
| 1    | &    | 且。相应位同1则1，否则为0             | `101&110=100`     |                                                    |
| 2    | \|   | 或。相应位有1则1，否则为0             | `101|110=111`     |                                                    |
| 3    | ^    | 异或。相应位有且只有一个1则1，否则为0 | `101^110=011`     |                                                    |
| 4    | ~    | 取反                                  | `~101=010`        | 二进101等于整数5                                   |
| 5    | <<   | 左移                                  | `1101<<3=1101000` | 相当于直接加3个0.<br>从整数的角度：13*2**3         |
| 6    | \>>  | 右移                                  | `1101>>3=1`       | 相当于删掉最后3位<br>从整数角度：`intval(13/2**3)` |

>位运算==非只有二进制才能使用，其他进制也可以==
>
>```php
>//十进制
>$a=3;
>$b=4;
>echo $a<<$b;//3*2**4=3*16=48
>```

### 7、数组运算符

| 序号 | 符号 | 作用         | 举例 | 备注                                            |
| ---- | ---- | ------------ | ---- | ----------------------------------------------- |
| 1    | +    | 合并数组     |      | `+`与`array_merge()`相反                        |
| 2    | ==   | 判断是否相等 |      |                                                 |
| 3    | ===  | 判断是否相等 |      | 判断k-v对的顺序以及v的类型(==不考虑key的类型==) |
| 4    | !=   | 判断是否相等 |      |                                                 |
| 5    | <>   | 判断是否相等 |      |                                                 |
| 6    | !==  | 判断是否相等 |      | 判断k-v对的顺序以及v的类型(==不考虑key的类型==) |



>`+`和`array_merge()`相反。
>
>当出现相同的key时。
>
>* `+`保留==第一次出现==的那个。
>* `array_merge()`保留==最后一次出现==那个
>
>```php
>$a = ['b' => 'b'];
>$b = ['b2' => 'b', 'b'=> 'bv'];
>var_dump($a+$b);//['b' => 'b', 'b2' => 'b']
>var_dump($b+$a);//['b2' => 'b', 'b' => 'bv']
>
>$x = [2 => 10, 3=> 20];
>$y = [3 => 20, 2 => 10];//换了顺序
>$z = ['2' => '10', 3 => 20];//改了key-value的类型
>$o = ['2' => 10, 3 => 20];//改了key的类型
>var_dump($x==$y);//true
>var_dump($x==$z);//true
>var_dump($x==$o);//true
>
>var_dump($x===$y);//false
>var_dump($x===$z);//false
>var_dump($x===$o);//true
>
>var_dump($x<>$y);//false
>var_dump($x<>$z);//false
>var_dump($x<>$o);//false
>
>var_dump($x!=$y);//false
>var_dump($x!=$z);//false
>var_dump($x!=$o);//false
>
>var_dump($x!==$y);//true
>var_dump($x!==$z);//true
>var_dump($x!==$o);//false
>```
>
>

### 8、其他

| 序号 | 符号       | 作用             | 举例                         | 备注                                             |
| ---- | ---------- | ---------------- | ---------------------------- | ------------------------------------------------ |
| 1    | =          | 赋值             | `$x=1;`                      |                                                  |
| 2    | @          | 任何错误都被忽略 | `$x=@$_GET['x'];`            |                                                  |
| 3    | \`...`     | 执行运算符       | *echo \`ls -al\`;*           | php.ini的safe_mode<br>关闭了`shell_exec()`时无效 |
| 4    | instanceof | 判断类型         | `$var instanceof $className` | className带命名空间                              |



## (四)、流程控制

### 1、循环

#### (1)、for

#### (2)、while

#### (3)、do...while

#### (4)、foreach

(5)、

(6)、

### 2、条件判断

#### (1)、if...[elseif]...[else]

>
>
>```php
>if(true){
>    echo "I am true";
>}else{
>    echo "I am false";
>}
>
>/**********************/
>
>$var= rand(0,2);
>if($var == 0){
>    echo "I am 0";
>}elseif($var == 1){   //1、elseif可以无限个
>    echo "I am 1";
>}else if($var == 2){//2、else和if既可以挨着也可以中间有空格
>    echo "I am 2";
>}else{
>    echo "不可能，总共才012"；
>}
>
>/********替代语法格式**************/
>
>if($var == 0):
>	echo "I am 0";
>elseif($var == 1):
>	echo "I am 1";
>else if($var == 2)://这里不支持else与if中间有空格，若有将无法编译
>	echo "I am 2";
>else:
>	echo "不可能，总共才012";
>endif;
>```
>
>

#### (2)、switch

### 3、跳转

### 4、流程控制中断

### 5、异常

### 6、引入文件

#### (1)、include/include_once

#### (2)、require/require_once

### 7、其他

(1)、goto

(2)、declare

(3)、return

(4)、echo

continue

breake

## (五)、function(不区分大小写)

### 1、命名规则

>`[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*`
>
>==不区分大小写==
>
>```php
>function myfun(){ echo "hello world!";}
>```
>
>



### 2、声明定义和初始化

函数没有初始化。仅是为了让标题统一

#### (1)、普通定义

>```php
>function myfun(){ echo "hello world!";}
>```

#### (2)、条件定义

>```php
>$flag = rand(0, 1);
>if($flag){
>    	function myFun(){ echo "hello world!";}
>}
>if($flag) {
>    	myFun();//正常调用
>}else{
>    	myFun();//报错，myFun未定义
>}
>```

#### (3)、函数中定义

>```php
>function outFun(){
>        function innerFun(){
>            echo 'hello world!';
>        }
>}
>//innerFun();//这里会报错，innerFun未定义
>outFun();
>innerFun();//正常调用
>```

#### (4)、定义可变数量参数的函数

>即：定义函数的时候，参数个数不确定。比如`array_merge($arr1, $arr2, $arr3)`
>
>`func_num_args()`获取参数的个数
>
>`func_get_args()`获取全部参数
>
>`func_get_arg($int)`获取第`$int`个参数。从0计数
>
>```php
>function myFun(...$params){//三个点号标识可以无限个参数。参数名和参数值以键值对放在$params中
>    	var_dump($params);//['a', 'b', 'c', 'd', 'e', 'f']
>    	var_dump(func_num_args());//6
>    	var_dump(func_get_args());//['a', 'b', 'c', 'd', 'e', 'f']
>    	var_dump(func_get_arg(2));//c
>}
>myFun('a', 'b', 'c', 'd', 'e', 'f');
>```
>
>

### 3、函数参数

#### (1)、默认值

> ```php
> function myFun($a, $b=2)
> {
>     var_dump($a, $b);
> }
> ```

#### (2)、强制类型(?/int)

> ```php
> function myFun($a, int $b)
> {
>     var_dump($a, $b); 
> }
> 
> function myFun($a, ?int $b)//$b要么是int要么为null,其他会报error php7.1+
> {
>     var_dump($a, $b); 
> }
> ```

#### (3)、引用参数

> ```php
> function myFun($a, &$b)
> {
>     var_dump($a, $b)
> }
> ```

### 4、变参函数的定义与使用

>定义
>
>```php
>function myFun($a, $b, ...$r){
>    var_dump($a, $b, $r);
>}
>
>myFun(1,2,3,4,5,6);
>/**
>$a = 1;
>$b = 2;
>$r = [4,5,6];
>*/
>```
>
>使用
>
>==在一维非关联数组前加三个点号==
>
>```php
>$a = [
>    ['a'=>1,'b'=>2,'c'=>3],
>    ['a'=>21,'b'=>22,'c'=>23],
>];
>
>array_map(function (...$p){
>    var_dump($p);
>}, ...[array_column($a, 'a'), array_column($a, 'b')]);
>
>```
>
>
>
>

### 5、强制函数返回数据类型

>* ==php5.6不支持==
>
>```php
>//强制return float 
>function fdiv(float $dividend, float $divisor): float { 
>     return p\Php80::fdiv($dividend, $divisor); 
> }
>```

### 6、重载和递归

#### (1)、函数重载

>php不支持函数重载
>
>```php
>function myFun(){echo "hello world!";}
>function myFun($p1, $p2){echo "{$p1}--hello world!--{$p2}";}//报错，myFun已定义
>```

#### (2)、递归函数

>php建议递归的层次不要超过100-200层。==可能造成堆栈崩溃==
>
>```php
>function myFun($i = 0){
>    if($i < 20){
>        myFun($i++);//递归
>    }
>}
>```
>
>
>
>

### 7、可变函数

>核心：把函数名传给一个变量，通过变量实现调用函数
>
>==可变函数不能用于例如 echo，print，unset()，isset()，empty()，include，require 以及类似的语言结构==

#### (1)、示例一：普通函数

>```php
>function myFun($p1){
>	echo "test:".__FUNCTION__."。param:".$p1.PHP_EOL;    
>}
>//【步骤一】、定义可变函数【把函数名给变量】
>$var = "myFun";
>//【步骤二】、调用可变函数
>$var("param1");//输出test:myFun
>```



> ##### 变量名与函数名相同
>
> 好像完全没影响
>
> ```php
> $myFun = "I am a var";
> function myFun($p1){
> 	echo "test:".__FUNCTION__."。param:".$p1.PHP_EOL;    
> }
> //【步骤一】、定义可变函数【把函数名给变量】
> $var = "myFun";
> //【步骤二】、调用可变函数
> $var("param1");//输出test:myFun
> ```
>
> 



#### (2)、示例二：类静态方法

>```php
>namespace a\b\c\d{
>    class MyClass{
>        public static function myStaticFun($p1){
>            echo "test:".__METHOD__."。param:".$p1.PHP_EOL;
>        }
>    }
>}
>
>namespace namespace2{
>    //【步骤一】、定义可变函数【把函数名给变量】【支持命名空间】
>    $var = "a\b\c\d\MyClass::myStaticFun";
>    //【步骤二】、调用可变函数
>    $var("param1");//
>}
>
>   
>```

>
>
>##### 类静态方法名与类属性名重复
>
>```php
>class MyClass{
>public static $var = "I am static property";
>public static function myStaticFun(){
>   echo "I am class::static-method";
>}
>}
>
>$var = "myStaticFun";
>
>echo MyClass::$var; //I am static property
>echo PHP_EOL;
>echo MyClass::$var();//I am class::static-method
>```
>
>

#### (3)、示例三：类方法

>这里有两个情况：
>
>* ✔仅仅是方法成了可变函数
>* ✘【类+类方法】这个整体成为可变函数





##### (a)、仅方法成可变函数

>```php
>class MyClass{
>public function myFun($p1){
>  echo "test:".__METHOD__."。param:".$p1.PHP_EOL;
>}
>}
>
>$obj = new MyClass();
>$var = "myFun";
>$obj->$var("param1");//test:MyClass::myFun。param:param1
>```
>
>##### 类方法名与类属性名重名情况
>
>>```php
>>class MyClass{
>>public $myFun = "I am property";
>>public function myFun($p1){
>>   echo "I am class::method";
>>}
>>}
>
>>$obj = new MyClass();
>>$var = "myFun";
>>echo $obj->$var;//输出 I am property
>>echo $obj->$var();//输出 I am class::method
>>
>>```

##### (b)、【类+类方法】整体成可变函数

>```php
>好像压根儿不支持
>```

### 8、相关函数

| 函数                       | 功能 | 参数 | 返回值版本 | 备注 |
| -------------------------- | ---- | ---- | ---------- | ---- |
| call_user_func_array       |      |      |            |      |
| call_user_func             |      |      |            |      |
| create_function            |      |      |            |      |
| forword_static_call_array  |      |      |            |      |
| forward_static_call        |      |      |            |      |
| func_get_arg               |      |      |            |      |
| func_get_args              |      |      |            |      |
| func_num_args              |      |      |            |      |
| function_exists            |      |      |            |      |
| get_defined_functions      |      |      |            |      |
| register_shutdown_function |      |      |            |      |
| register_tick_function     |      |      |            |      |
| unregister_tick_function   |      |      |            |      |



## (六)、对象

### 概念

#### (1)、名称规则

>```php
>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
>```

#### (2)、访问控制



| 关键字    | 访问       | 继承       | 备注 |
| --------- | ---------- | ---------- | ---- |
| public    | 允许       | 允许       |      |
| protected | ==不==允许 | 允许       |      |
| private   | ==不==允许 | ==不==允许 |      |



>```php
>class Aa{
>    public $p1=1;
>    protected $p2=2;
>    private $p3=3;
>
>    public function test1(){
>        return "test1<br>";
>    }
>    protected function test2(){
>        return "test2<br>";
>    }
>    private function test3(){
>        return "test3<br>";
>    }
>}
>
>class Bb extends Aa{
>
>    public function t1(){
>        return $this->test1();
>    }
>
>    public function t2(){
>        return $this->test2();
>    }
>
>    public function t3(){
>        return $this->test3();
>    }
>}
>
>
>$obj = new Aa();
>$obj2 = new Bb();
>/*********属性、类变量********/
>echo $obj->p1;
>//echo $obj->p2;//protected调用报错
>//echo $obj->p3;//private调用报错
>
>echo $obj2->p1;
>//echo $obj2->p2;//protected调用报错
>//echo $obj2->p3;//private调用报错
>
>/*********类function********/
>echo $obj->test1();
>//echo $obj->test2();//protected调用报错
>//echo $obj->test3();//private调用报错
>
>echo $obj2->t1();
>echo $obj2->t2();//protected可以被继承
>echo $obj2->t3();//private继承报错
>```

#### (3)、static(静态)

>仅属性(字段)、方法(函数)支持设置static(静态)，类常量不需要
>
>设置了static，不论是属性还是方法，一旦调用，就会存在内存中，直到本次请求结束
>
>设置了static的属性和方法，==调用方式[self|parent|className]::$var，不能用\$this调用。==
>
>设置值仅支持：
>
>* [boolean|integer|float|string|null|array]+已定义的常量。
>* 不支持调用，回调等方式。
>
>==符类的static 属性会被子类共享==



>```php
>public static $var;
>public static function myFun(){}
>```

##### a、后期静态绑定

```php
get_called_class
```

#### (4)、final

#### (5)、命名空间

#### (6)、自动加载

spl_autoload_register()

__construct()

#### (7)、魔术方法

| 方法               | 功能 | class | trait | abstract | interface | 备注           |
| ------------------ | ---- | ----- | ----- | -------- | --------- | -------------- |
| `__construct(...)` |      |       |       |          |           |                |
| `__destruct()`     |      |       |       |          |           | exit/die呢？？ |
| `__call()`         |      |       |       |          |           |                |
| `__callStatic()`   |      |       |       |          |           |                |
| `__get()`          |      |       |       |          |           |                |
| `__set()`          |      |       |       |          |           |                |
| `__isset()`        |      |       |       |          |           |                |
| `__unset()`        |      |       |       |          |           |                |
| `__sleep()`        |      |       |       |          |           |                |
| `__wakeup()`       |      |       |       |          |           |                |
| `__toString()`     |      |       |       |          |           |                |
| `__invoke()`       |      |       |       |          |           |                |
| `__set_state()`    |      |       |       |          |           |                |
| `__clone()`        |      |       |       |          |           |                |
| `__debugInfo()`    |      |       |       |          |           |                |



#### (8)继承

##### a、self、parent、static

* ==parent==既可以调用父类的==静态方法==，也可以调用==非静态方法==。调用格式`parent::方法名/类常量/类变量`

>
>
>```php
>class A{
>    function static m(){ echo "I am in A;"}
>}
>class B extends A(){
>    function static m(){echo "I am in B"}
>    function varDump(){
>        parent::m();
>        self::m();
>        static::m()
>    }
>}
>class C extends B{
>    function static m(){echo "I am in C"}
>}
>class D extends C{
>    function static m(){echo "I am in D"}
>}
>
>
>
>$obj = new C();
>$obj->varDump();//A B D
>//parent  当前物理文件的父级
>//self    当前物理文件
>//static  最接近当前对象的那个(这里当前对象是D)
>```
>
>



>
>
>```php
>class A{
>    function m(){ echo "I am in A;"}
>}
>class B extends A(){
>    function m(){echo "I am in B"}
>    function varDump(){
>        
>    }
>}
>class C extends B{
>    function m(){echo "I am in C"}
>}
>class D extends C{
>    function m(){echo "I am in D"}
>}
>
>//如何在B中掉abcd
>```
>
>

##### b、继承覆盖问题

>* 变量会被覆盖
>* 常量会被覆盖
>* 方法继承，
>* * 参数只能增不能减。
>  * 增的部分必须有默认值
>  * 比如下面的如若p2不赋默认值，则会warning
>
>```php
>class A{
>    public $a =1;
>    const CONS =2;
>
>    public function fun($p1){
>        echo "A::fun(p1)";
>    }
>}
>
>
>class B extends A{
>    public $a=11;
>    const CONS = 22;
>
>    public function fun($p1, $p2=2){//fun($p1, $p2) Warning: Declaration of B::fun($p1, $p2) should be compatible with A::fun($p1)
>        echo "B::fun(p1,p2)";
>    }
>}
>
>var_dump((new B())->a);//11
>var_dump(B::CONS);//22
>var_dump((new B())->fun(1,2));//B::fun(p1,p2)
>```
>
>

### 1、class

| 组成   | 定义                                       | 备注 |
| ------ | ------------------------------------------ | ---- |
| 属性   | [public\|private\|protected]+[static]+$var |      |
| 类常量 | const+constName                            |      |
| 方法   |                                            |      |

#### (1)、类变量

###### a、如何定义属性

>1. 访问控制  public/private/protected/无
>2.  是否静态 static/无
>
>```php
>$property;
>public $property;
>public static $property;
>```



###### b、定义属性并赋值举例：

>* 错误举例
>
>  ```php
>  $property = 1+2;
>  $property = 'a' .'b';
>  $property = $property2;            //不可以赋值变量，但可以赋值常量
>  $property = self::myFun();
>  $property = $this->myFun();
>  $property = bcadd('1', '2');
>  $property = <<<label     
>  	abcd
>  	label;
>  ```
>
>* 正确举例
>
>  ```php
>  $property;               //不赋值也是可以的
>  $property = 'abcd';      //直接赋原始值
>  $property = PHP_INT_MAX; //赋值常量
>  $property = ['a', 'b'];  //赋值数组 
>  $property = <<<'label'     //php >= 5.3.0
>  	abcd
>  	label;
>  ```

###### c、调用方式

>```php
>//类内部调用
>echo $this->property;//$property         $object->property
>echo self::$property;//static $property  [self | parent | className]
>```
>
>

#### (2)、类常量

##### a、定义规则：

>1. 声明定义时必须赋值
>2. 类常量名称==不能使用\$==
>3. 不能加访问控制
>4. 类常量的值必须是一个==定值==;不能是类属性，不能是变量，不能是数学运算或函数调用结果
>5. php7.1+支持设置访问控制(公开、保护、私有)
>
>```php
>const myConstant='abcd';
>const myConstant=['a','b','c'];
>const myConstant=<<<'label'//php>=5.3.0
>  abcd
>  label;
>
>public const myConstant='aaa';
>//const public myConstant='aaa';//这个写法会报错
>```
>
>

##### b、调用方式

>```php
>echo self::myConstant;
>echo className::myConstant;
>```
>
>

#### (3)、类function

访问控制(可见性)

>即 public、private、protected
>
>==若没有标明访问控制，默认public==

###### (I)、构造函数、析构函数

>```php
>//不能被继承？？？
>```
>
>

###### (II)、final方法

#### (2)、特殊class

##### a、匿名类

>
>
>零时创建一个类。这个和临时创建function有点像。
>
>```php
>$a = new Class{
>    function a(){
>        echo "I am a class";
>    }
>}
>$f = function(){
>    echo "I am a function";
>}
>
>$a->a();//I am a class
>$f();//I am a function
>```
>
>

##### b、final类

### 2、abstract class和interface

| 序号 | 对比项 | abstract class | interface | 备注 |
| ---- | ------ | -------------- | --------- | ---- |
| 1    | 类变量 | 支持           | 不支持    |      |
| 2    | 类常量 | 支持           | 支持      |      |
| 3    |        |                |           |      |
| 4    |        |                |           |      |
| 5    | 继承   | 单继承         | 多继承    |      |

#### (1)、abstract class

##### (a)、定义

>**定义规则**
>
>* 抽象类不能被实例化(仅模板，不可应用/调用)
>* ==至少有一个方法==被声明为abstract(不限public、private、protected)：抽象方法
>* 声明abstract方法，到参数就结束没有大括号{}
>
>

```php
abstract class MyClass{
    public abstrct function a();//这里没有{}
}
```

##### (b)、继承与实现

>**继承规则**
>
>* 子类在实现具体的抽象方法，其==访问控制==应该一样或==更宽松==
>* 子类实现抽象方法时，必须有原来的响应参数和类型，此外可以额外增加(==参数只能增不能减==)
>
>```php
>abstract class A{
>    abstract private function a($p1,$p2);
>}
>
>class B extend A{
>    public function a($p1, $p2, $px, $py){
>        var_dump($p1,$p2,$px,$py); 
>    }
>}
>```
>
>

#### (2)、interface

##### (a)、定义

>**定义规则**
>
>* 类用interface关键字定义
>* 所有的==方法全部空==的(没有具体的实现，没有{})
>* 所有的方法==必须是公有的==
>* 允许定义==构造方法==，同样不可具体实现
>* ==可以定义类型量==
>
>

##### (b)、继承与实现

单继承

>



多继承，排重问题

### 3、trait

只是一种==代码复用机制==。与对象概念无关。



|            | 成员                                            | 是否支持 |
| ---------- | ----------------------------------------------- | -------- |
| 变量       | `private $a;`                                   |          |
|            | `protected $b1;`<br>`public $b2;`               |          |
| static变量 | `privatre static $c`                            |          |
|            | `protected static $d; `<br>`public static $d; ` |          |
| const常量  | `p`                                             |          |
|            |                                                 |          |
|            |                                                 |          |

> ```php
> priv
> ```
>
> 





### 相关函数

| 函数                     | 功能              | 参数 | 返回值版本 | 备注 |
| ------------------------ | ----------------- | ---- | ---------- | ---- |
|                          | 类名              |      |            |      |
|                          | 类名(带namespace) |      |            |      |
|                          | method名          |      |            |      |
|                          | method名(带类名)  |      |            |      |
| `__autoload`             |                   |      |            |      |
| `call_user_method_array` |                   |      |            |      |
| `call_user_method`       |                   |      |            |      |
| `class_exists`           |                   |      |            |      |
| `get_called_class`       |                   |      |            |      |
| `get_class_methods`      |                   |      |            |      |
| `get_class_vars`         |                   |      |            |      |
| `get_class`              |                   |      |            |      |
| `get_declared_classes`   |                   |      |            |      |
| `get_declared_interface` |                   |      |            |      |
| get_object_vars          |                   |      |            |      |
| get_parent_class         |                   |      |            |      |
| interface_exists         |                   |      |            |      |
| is_a                     |                   |      |            |      |
| is_subclass_of           |                   |      |            |      |
| method_exists            |                   |      |            |      |
| property_exists          |                   |      |            |      |
| trait_exists             |                   |      |            |      |

## (七)、进程性指令

exit();sleep();die;



## (八)、错误与异常

### 1、错误

>**Error** 类并非继承自 [Exception](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/class.exception.html)   类，所以不能用 `catch (Exception $e) { ... }` 来捕获   **Error**。你可以用   `catch (Error $e) { ... }`，或者通过注册异常处理函数（   [set_exception_handler()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.set-exception-handler.html)）来捕获 **Error**。 

#### (1)、错误控制符@

>PHP 手册>>语言参考>>运算符
>
>
>
>@。当将其放置在一个 PHP 表达式之前，该表达式可能产生的任何错误信息都被忽略掉
>
>**注意**: 
>
>* @ 运算符只对[表达式](https://www.php.net/manual/zh/language.expressions.php)有效。
>* 对新手来说一个简单的规则就是：如果能从某处得到值，就能在它前面加上 @ 运算符。
>* 例如，可以把它放在变量，函数和 [include](https://www.php.net/manual/zh/function.include.php) 调用，常量，等等之前。
>* 不能把它放在函数或类的定义之前，也不能用于条件结构例如 `if` 和 [foreach](https://www.php.net/manual/zh/control-structures.foreach.php) 等。







>
>
>[PHP Manual] -> [错误处理] -> 预定义常量
>
>| 值    | 常量                      | 说明                                                         | 备注                                                         |
>| ----- | ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
>| 1     | **`E_ERROR`**             | 致命的运行时错误。这类错误一般是不可恢复的情况，例如内存分配导致的问题。后果是导致脚本终止不再继续运行。 |                                                              |
>| 2     | **`E_WARNING`**           | 运行时警告 (非致命错误)。仅给出提示信息，但是脚本不会终止运行。 |                                                              |
>| 4     | **`E_PARSE`**             | 编译时语法解析错误。解析错误仅仅由分析器产生。               |                                                              |
>| 8     | **`E_NOTICE`**            | 运行时通知。表示脚本遇到可能会表现为错误的情况，但是在可以正常运行的脚本里面也可能会有类似的通知。 |                                                              |
>| 16    | **`E_CORE_ERROR`**        | 在PHP初始化启动过程中发生的致命错误。该错误类似       **`E_ERROR`**，但是是由PHP引擎核心产生的。 | since PHP 4                                                  |
>| 32    | **`E_CORE_WARNING`**      | PHP初始化启动过程中发生的警告 (非致命错误) 。类似 **`E_WARNING`**，但是是由PHP引擎核心产生的。 | since PHP 4                                                  |
>| 64    | **`E_COMPILE_ERROR`**     | 致命编译时错误。类似**`E_ERROR`**,       但是是由Zend脚本引擎产生的。 | since PHP 4                                                  |
>| 128   | **`E_COMPILE_WARNING`**   | 编译时警告 (非致命错误)。类似       **`E_WARNING`**，但是是由Zend脚本引擎产生的。 | since PHP 4                                                  |
>| 256   | **`E_USER_ERROR`**        | 用户产生的错误信息。类似       **`E_ERROR`**, 但是是由用户自己在代码中使用PHP函数 [trigger_error()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.trigger-error.html)来产生的。 | since PHP 4                                                  |
>| 512   | **`E_USER_WARNING`**      | 用户产生的警告信息。类似       **`E_WARNING`**, 但是是由用户自己在代码中使用PHP函数 [trigger_error()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.trigger-error.html)来产生的。 | since PHP 4                                                  |
>| 1024  | **`E_USER_NOTICE`**       | 用户产生的通知信息。类似       **`E_NOTICE`**, 但是是由用户自己在代码中使用PHP函数 [trigger_error()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.trigger-error.html)来产生的。 | since PHP 4                                                  |
>| 2048  | **`E_STRICT`**            | 启用 PHP 对代码的修改建议，以确保代码具有最佳的互操作性和向前兼容性。 | since PHP 5                                                  |
>| 4096  | **`E_RECOVERABLE_ERROR`** | 可被捕捉的致命错误。 它表示发生了一个可能非常危险的错误，但是还没有导致PHP引擎处于不稳定的状态。 如果该错误没有被用户自定义句柄捕获 (参见       [set_error_handler()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.set-error-handler.html))，将成为一个 **`E_ERROR`**　从而脚本会终止运行。 | since PHP 5.2.0                                              |
>| 8192  | **`E_DEPRECATED`**        | 运行时通知。启用后将会对在未来版本中可能无法正常工作的代码给出警告。 | since PHP 5.3.0                                              |
>| 16384 | **`E_USER_DEPRECATED`**   | 用户产少的警告信息。 类似       **`E_DEPRECATED`**, 但是是由用户自己在代码中使用PHP函数 [trigger_error()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.trigger-error.html)来产生的。 | since PHP 5.3.0                                              |
>| 30719 | **`E_ALL`**               | **`E_STRICT`**出外的所有错误和警告信息。                     | 30719 in PHP 5.3.x,      6143 in PHP 5.2.x,      2047 previously |



>
>
>```php
>    public function actionW5(){
>        try {
>            (new \stdClass())->o();//触发捕获error:Call to undefined method stdClass::o()
>
>            var_dump(1/0);//触发捕获exception：Division by zero
>        }catch (\Error $er){
>            var_dump('error:' .$er->getMessage());
>        }catch (\Exception $ep){
>            var_dump('exception:'.$ep->getMessage());
>        }
>    }
>```





>
>
>- **Throwable**
>  - **Error**
>    - **ArithmeticError**
>      - **DivisionByZeroError**          
>    - **AssertionError**        
>    - **CompileError**
>      - **ParseError**          
>    - **TypeError**
>      - **ArgumentCountError**          
>  - [Exception](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/class.exception.html)
>    - ... 

## (九)、其他语法

### 1、引用

>
>
>```php
>$a =1;
>$b= &$a;
>
>function myFyn(&$param){
>    
>}
>
>foreach($array as &$key => &$value){
>    
>}
>
>function &get_instance_ref() {
>    static $obj;
>
>    echo 'Static object: ';
>    var_dump($obj);
>    if (!isset($obj)) {
>        // 将一个引用赋值给静态变量
>        $obj = &new stdclass;
>    }
>    $obj->property++;
>    return $obj;
>}
>```

### 2、namespace

#### 同一个文件中多个namespace

> ```php
> <?php
> namespace a\b\c\d {
>     class Aa{
>         public function aa(){
>             echo __FILE__;
>         }
>     }
> }
> namespace aa{
>     $o = new \a\b\c\d\Aa();
>     $o->aa();
> }
> 
> $o = new \a\b\c\d\Aa();//这样写会报错
> $o->aa();
> ```

## (十)、语法层次的判断与获取

### 1、判断数据类型

>
>
>| 序号 | 功能             | 示例                                                | 备注               |
>| ---- | ---------------- | --------------------------------------------------- | ------------------ |
>| 1    | 是否是bool       | `is_bool($var)`                                     |                    |
>| 2    | 是否是integer    | `is_int($var)`或`is_integer($var)`或`is_long($var)` | `is_numeric($var)` |
>| 3    | 是否是float      | `is_float($var)`或`is_real($var)`                   | `is_numeric($var)` |
>| 4    | 是否是string     | `is_string($var)`                                   |                    |
>| 5    | 是否是null       | `is_null($var)`                                     |                    |
>| 6    | 是否是array      | `is_array($var)`                                    |                    |
>| 7    | 是否是object     | `is_object($var)`                                   |                    |
>| 8    | 是否是callback   | `is_callable($var)`                                 |                    |
>| 9    | 是否是resource   | `is_resource($var)`                                 |                    |
>|      |                  |                                                     |                    |
>|      | 是否是标量       | `is_scalar($var)`                                   |                    |
>|      | 判断不是合法数值 | `is_nan($var)`                                      | NAN                |

#### (1)、is_numeric

 >判断变量是否是数字(int+float)或者字符型数字

#### (2)、is_callable

>* `is_callable( callable $name[, bool $syntax_only = false[, string &$callable_name]] ) : bool`

#### (3)、is_scalar

>判断是否为标量。
>
>==什么是标量？

>```php
>var_dump(is_scalar(false));//true
>var_dump(is_scalar(1));    //true
>var_dump(is_scalar(1.2));  //true 
>var_dump(is_scalar('a'));  //true
>var_dump(is_scalar(null));          //false
>var_dump(is_scalar(new stdClass()));//false
>var_dump(is_scalar([]));            //false
>var_dump(is_scalar(function(){}));  //false
>var_dump(is_scalar(NAN));         //true 
>var_dump(is_scalar(acos(8)));     //true
>```

#### (4)、is_nan

> ```php
> var_dump(is_nan(acos(0.6)));//false  结果是合法数值
> var_dump(is_nan(acos(6.6)));//true   acos最大为1.
> var_dump(is_nan(NAN));//true
> ```

### 2、获取代码位置相关信息

#### (1)、获取代码相关物理信息

> | 序号                    | 示例                                            | 备注           |
> | ----------------------- | ----------------------------------------------- | -------------- |
> | 代码所在文件            | `__DIR__`                                       | 仅路径         |
> |                         | `basename(__FILE__)`                            | 仅文件名       |
> |                         | `__FILE__`                                      | 路径+文件名    |
> | 代码所在行数            | `__LINE__`                                      |                |
> | 代码所在namespace       | `__NAMESPACE__`                                 |                |
> | 代码所在类名            | `(new \ReflectionClass($this))->getShortName()` | 仅类名         |
> |                         | `__CLASS__`                                     | namespace+类名 |
> | 代码所在method/function | `__FUNCTION__`                                  | 仅method名     |
> |                         | `__METHOD__`                                    | 类名::method名 |

动态的。根据继承关系。输出结果不同 

> | 序号         | 示例                 | 备注          |
> | ------------ | -------------------- | ------------- |
> | 代码所在类名 | `get_called_class()` | 继承.静态绑定 |



> 文件   c:\code\test.php
>
> ```php
> <?php
> namespace my_namespace1\tab1 {
> 
>     class MyClassBase{
>         public function myMethod(){
>             echo __FILE__.PHP_EOL;           //c:\code\test.php
>             echo basename(__FILE__).PHP_EOL; //test.php
>             echo __DIR__.PHP_EOL;            //c:\code
>             echo  __LINE__.PHP_EOL;          //10
> 
>             echo __NAMESPACE__.PHP_EOL;             //my_namespace1\tab1
>             echo __CLASS__.PHP_EOL;                 //my_namespace1\tab1\MyClassBase
>             echo get_called_class().PHP_EOL;        //my_namespace1\tab1\MyClass
>             echo __TRAIT__.PHP_EOL;                 //与class差不多
>             echo (new \ReflectionClass($this))->getShortName().PHP_EOL;//Myclass
> 
>             echo __METHOD__.PHP_EOL;     //my_namespace1\tab1\MyClass::myMethod
>             echo __FUNCTION__.PHP_EOL;   //myMethod
>         }
>     }
>     class MyClass extends MyClassBase {
>     }
> }
> 
> namespace my_namespace2\tab2{
>     use my_namespace1\tab1\MyClass;
>     $object = new MyClass();
>     $object->myMethod();
> }
> ```
>
> 

#### (2)、获取代码相关逻辑信息

>
>
>| 序号 | 功能                       | 示例 | 备注 |
>| ---- | -------------------------- | ---- | ---- |
>|      | 哪个文件在调用这个method   |      |      |
>|      | 文件的哪行在调用这个method |      |      |
>|      | 哪个class在调用这个method  |      |      |
>|      | 哪个method在调用这个method |      |      |



> 共两个文件【c:\code\test.php】和【c:\code\test2.php】
>
> c:\code\test.php
>
> ```php
> <?php
> 
> 
> namespace my_namespace1\tab1 {
> 
>     class MyClass{
>         public function myMethod(){
> 
>         }
>     }
> }
> ```
>
> c:\code\test2.php
>
> ```php
> <?php
> 
> namespace my_namespace2\tab2 {
> 
>     use my_namespace1\tab1\MyClass;
> 
>     include __DIR__.DIRECTORY_SEPARATOR.'test.php';
> 
>     class MyClass2{
>         public function myMethod2(){
>             $object = new MyClass();
>             $object->myMethod();
>         }
>     }
> 
> 
>     (new MyClass2())->myMethod2();
> }
> ```
>
> 

# 三、预定义

## (一)、变量

## (二)、常量

## 预定义基础class或interface

>
>
>- [Traversable](https://www.php.net/manual/en/class.traversable.php)
>- [Iterator](https://www.php.net/manual/en/class.iterator.php)
>- [IteratorAggregate](https://www.php.net/manual/en/class.iteratoraggregate.php)
>- [Throwable](https://www.php.net/manual/en/class.throwable.php)
>- [ArrayAccess](https://www.php.net/manual/en/class.arrayaccess.php)
>- [Serializable](https://www.php.net/manual/en/class.serializable.php)
>- [Closure](https://www.php.net/manual/en/class.closure.php)
>- [Generator](https://www.php.net/manual/en/class.generator.php)
>- [WeakReference](https://www.php.net/manual/en/class.weakreference.php)

(一)、预定义数据载体

(二)、预定义异常





# 四、常用功能

>其实所谓的功能扩展部分，完全是==函数的调用==了。没有新的语法规则了。

## (一)、cookie与seesion

### 1、cookie

#### (1)、存入cookie

##### a、setcookie

>setcookie和setrawcookie
>
>* setcookie发送的value会被URL 编码（urlencode）。
>* setrawcookie发送明文value，不会被编码
>
>==支持发送数组==
>
>```php
>//涉及函数
>//setcookie( string $name[, string $value = ""[, int $expire = 0[, string $path = ""[, string $domain = ""[, bool $secure = false[, bool $httponly = false]]]]]] ) : bool
>//setrawcookie( string $name[, string $value[, int $expire = 0[, string $path[, string $domain[, bool $secure = false[, bool $httponly = false]]]]]] ) : bool
>
>setcookie("cookie_key", 'index.php?a=1&b=2');          //设置cookie。浏览器看到的是：index.php%3Fa%3D1%26b%3D2
>setcookie("cookie_key2", 'value2', time() + 7 * 86400);//设置cookie一周有效
>setcookie("cookie_arr[k1]", 'v1');
>setcookie("cookie_arr[k2]", 'v2');
>setrawcookie("cookie_raw_key", 'index2.php?a=1&b=2');   //明文value。浏览器看到的是：index2.php?a=1&b=2
>
>var_dump($_COOKIE);
>/*
>[
>    'cookie_key' => 'index.php?a=1&b=2',
>    'cookie_key2' => 'value2',
>    'cookie_arr' => [
>        'k1' => 'v1',
>        'k2' => 'v2'
>    ],
>    'cookie_raw_key' => 'index.php?a=1&b=2'
>]
>*/
>```
>
>| 参数       | 含义                                                         |
>| ---------- | ------------------------------------------------------------ |
>| \$name     | cookie的key                                                  |
>| \$value    | cookie的value                                                |
>| \$expire   | 1、\$expire=0，关闭浏览器，cookie则失效。不关闭一直存在<br>2、过一周过期？\$expire = time()+7*86400 |
>| \$path     |                                                              |
>| \$domain   | cookie对指定域名有效                                         |
>| \$secure   |                                                              |
>| \$httponly | httponly                                                     |



##### b、header

>```php
>header("Set-Cookie: $cookieName=$cookieValue; expires=$cookieExpire; path=/; domain=$cookieDomain;  SameSite=None; Secure");
>//$cookieExpire = date("Wdy, DD-Mon-YYYY HH:MM:SS GMT", strtotime("2999-12-12 00:00:00"));
>
>```
>
>

#### (2)、从cookie中获取

>```php
>//获取当前的全部cookie
>$_COOKIE;
>//获取某个key的cookie
>$_COOKIE['key'];//如果key不存在，将被警告未定义
>
>//如果在php.ini中 request_order的值包含 ‘C’,则还可以这样调
>$_REQUEST;
>$_REQUEST['key'];
>```

### 2、session

>开启session：
>
>* session.auto_start = 1和session_start()不能共存，会有警告：**A session had already been started**
>* session不论是存数还是取数，都要求session状态为active（即session.auto_start = 1或session_start()）
>
>和开启session相关事件
>
>* ==未开启session，\$_SESSION是未定义的==

#### (1)、存入session

>存入session或修改已存在的
>
>必须判断session的状态
>
>```php
>if(session_status() != PHP_SESSION_ACTIVE) session_start();
>$_SESSION['key'] ='value';
>```
>
>从session中删除
>
>```php
>if(session_status() != PHP_SESSION_ACTIVE) session_start();
>if(isset($_SESSION['key'])) unset($_SESSION['key']);
>```
>
>

#### (2)、从session中获取

>```php
>if(session_status() != PHP_SESSION_ACTIVE) session_start();
>return $_SESSION['key'] ?? null;//默认不存在的时候返回null
>```



#### (3)、自定义存储

* ==session.auto_start =1不能使用session_set_save_handler==

```html
Warning: session_set_save_handler(): Cannot change save handler when session is active
```

* 加载文件时可以考虑，spl_autoload_regitster()

>```php
>//一、函数调用  open/close/...created_sid等都是函数
>session_set_save_handler ($open, $close, $read, $write, $destroy, $gc, $create_sid = null, $validate_sid = null,  $update_timestamp = null);
>//二、对象中得方法，没有继承相应接口
>session_set_save_handler(
>                    [$this, 'openSession'],
>                    [$this, 'closeSession'],
>                    [$this, 'readSession'],
>                    [$this, 'writeSession'],
>                    [$this, 'destroySession'],
>                    [$this, 'gcSession']
>                );
>//三、对象，继承接口
>session_set_save_handler (SessionHandlerInterface $session_handler, $register_shutdown = true);
>    
>```
>
>

| 类/接口                 | 方法                                | 返回值 | 备注       |
| ----------------------- | ----------------------------------- | ------ | ---------- |
| SessionHandlerInterface | `open($save_path, $name)`           | bool   | 存储handle |
|                         | `close()`                           | bool   | 存储handle |
|                         | `write($session_id, $session_data)` | bool   | 数据       |
|                         | `read($session_id)`                 | string | 数据       |
|                         | `destroy($session_id)`              | bool   | 数据       |
|                         | `gc($maxlifetime)`                  | bool   | 回收机制   |
| SessionIdInterface      | `create_sid()`                      | string | session_id |

>```php
>$o = new \flancklin\session\SessionHelper(new \flancklin\session\SessionHandlerMySql());
>var_dump($o->set("key","94444999"));
>var_dump($o->get("key"));
>
>//物理路径：/flancklin/session/autoload.php
>//物理路径：/flancklin/session/lib/SessionHelper.php
>//物理路径：/flancklin/session/lib/SessionHandlerXXX.php
>
>```

##### a、SessionHelper.php

>```php
><?php
>namespace flancklin\session;
>
>class SessionHelper{
>    private $handler = null;
>    function __construct($handler)
>    {
>        if($handler instanceof \SessionIdInterface) $this->handler = $handler;
>    }
>    /**
>     * 设置或修改session值
>     * @param $key
>     * @param $value
>     * @throws SessionStartFailException
>     */
>    public function set($key, $value){
>        $this->open();//开启sessin
>        $_SESSION[$key] = $value;
>    }
>    /**
>     * 删除某个session值
>     * @param $key
>     * @throws SessionStartFailException
>     */
>    public function delete($key){
>        $this->open();
>        if(isset($_SESSION[$key])) unset($_SESSION[$key]);
>    }
>    /**
>     * 获取某个session值
>     * @param $key
>     * @param null $default
>     * @return mixed|null
>     * @throws SessionStartFailException
>     */
>    public function get($key, $default = null){
>        $this->open();
>        return $_SESSION[$key] ?? $default;
>    }
>    /**
>     * 如果session没有开启，则开启。
>     * 如果session原本已开启，则无需多余操作
>     * @throws SessionStartFailException
>     */
>    private function open(){
>        if($this->isActive()) return ;
>        //php_ini:session.auto_start =1不能使用session_set_save_handler
>        //Warning: session_set_save_handler(): Cannot change save handler when session is active
>        $this->handler && session_set_save_handler($this->handler);
>        if(!session_start()){
>            throw new SessionStartFailException('open session failed');
>        }
>    }
>    /**
>     * 判断session是否已开启
>     * @return bool
>     */
>    private function isActive(){
>        return session_status() == PHP_SESSION_ACTIVE;
>    }
>}
>```
>
>

##### b、SessionHandler.php

>==这个handler有个bug，刷新session_id会变。但读取数都可以了==
>
>```php
><?php
>namespace flancklin\session;;
>
>/**
> * mysql表结构
>CREATE TABLE `sessions`  (
>`session_expires` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
>`session_data` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
>`session_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
>PRIMARY KEY (`session_id`) USING BTREE
>) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;
>
> * Class SessionHandlerMySql
> * @package flancklin\session
> */
>class SessionHandlerMySql implements \SessionHandlerInterface,\SessionIdInterface {//extends \SessionHandler {
>    private $link;
>    private $lifetime;
>
>    /**
>     * 数据库连接handle
>     * @param string $save_path
>     * @param string $name
>     * @return bool|void
>     */
>    public function open($save_path, $name){//Initialize session
>        $this->lifetime=get_cfg_var('session.gc_maxlifetime');
>        $this->link=mysqli_connect('localhost','root','','test');
>        mysqli_query($this->link,"SET names UTF8");
>        if($this->link){
>            return true;
>        }
>        return false;
>    }
>    /**
>     *关闭数据库连接handle
>     * (有些数据库不需要，直接return true)
>     * @return bool|void
>     */
>    public function close(){//Close the session
>        mysqli_close($this->link);
>        return true;
>    }
>    /**
>     * 存储session值
>     * @param string $session_id
>     * @param string $session_data
>     * @return bool|void
>     */
>    public function write($session_id, $session_data){//Write session data
>        $newExp=time()+$this->lifetime;
>        //首先查询是否存在指定的session_id,如果存在相当于更新数据，否则是第一次，则写入数据
>        $sql="SELECT * from sessions where session_id={'$session_id'}";
>        $result=mysqli_query($this->link,$sql);
>        if($result && mysqli_num_rows($result)==1){
>            $sql="UPDATE sessions set session_expires='{$newExp}',session_data='{$session_data}' 
>                  where  session_id='{$session_id}' ";
>        }else{
>            $sql="INSERT into sessions values('{$session_id}','$session_data','{$newExp}')";
>        }
>        mysqli_query($this->link,$sql);
>        return mysqli_affected_rows($this->link)==1;
>    }
>    /**
>     * 删除session值
>     * @param string $session_id
>     * @return bool|void
>     */
>    public function destroy($session_id){//Destroy a session
>        $sql="DELETE from sessions where session_id='{$session_id}'";
>        mysqli_query($this->link,$sql);
>        return mysqli_affected_rows($this->link)==1;
>    }
>    /**
>     * 读取session值
>     * @param string $session_id
>     * @return string|void
>     */
>    public function read($session_id){//Read session data
>        $sql="SELECT *from sessions where session_id='{$session_id}'
>              and session_expires >".time();
>        $result=mysqli_query($this->link,$sql);
>        if(mysqli_num_rows($result)){
>            return mysqli_fetch_array($result)['session_data'];
>        }
>        return "";
>    }
>    /**
>     * 自动删除过期session
>     * @param int $maxlifetime
>     * @return bool|void
>     */
>    public function gc($maxlifetime){//Cleanup old sessions
>        $sql="DELETE from sessions where session_expires<".time();
>        mysqli_query($this->link,$sql);
>        if(mysqli_affected_rows($this->link)>0){
>            return true;
>        }
>        return false;
>    }
>    public function create_sid() {
>        return rand(0,100);
>    }
>//    public function validateId($session_id) { }
>//    public function updateTimestamp($session_id, $session_data) { }
>
>}
>```
>
>

##### c、autoload.php

>
>
>```php
><?php
>spl_autoload_register(function ($class){
>    $classFile = strtr($class, ['flancklin\\'.basename(__DIR__).'\\' => __DIR__.DIRECTORY_SEPARATOR.'lib'.DIRECTORY_SEPARATOR]) . '.php';
>    if(is_file($classFile)){
>        include_once $classFile;
>    }
>});
>```
>
>

#### (4)、系统参数

##### a、预定义常量

| 常量标识             | 数据类型 | 含义              |
| -------------------- | -------- | ----------------- |
| SID                  | string   | url传递session_id |
| PHP_SESSION_DISABLED | int      |                   |
| PHP_SESSION_NONE     | int      |                   |
| PHP_SESSION_ACTIVE   | int      |                   |

>***session_status() 被用于返回当前会话状态。***
>
>
>返回值 
>
>◦ PHP_SESSION_DISABLED 会话是被禁用的。 
>◦ PHP_SESSION_NONE 会话是启用的，但不存在当前会话。 
>◦ PHP_SESSION_ACTIVE 会话是启用的，而且存在当前会话。 

#### 

##### b、php.ini配置

>
>
>下面是php.ini中session的配置说明：
>session.save_handler = "files"
> 存储和检索与会话关联的数据的处理器名字。默认为文件("files")。
> 如果想要使用自定义的处理器(如基于数据库的处理器)，可用"user"。
> 有一个使用PostgreSQL的处理器：http://sourceforge.net/projects/phpform-ext/
>
>
>
>session.save_path = "/tmp"
> 传递给存储处理器的参数。对于files处理器，此值是创建会话数据文件的路径。
> Windows下默认为临时文件夹路径。
> 你可以使用"N[MODE]/path"这样模式定义该路径(N是一个整数)。
> N表示使用N层深度的子目录，而不是将所有数据文件都保存在一个目录下。
> [MODE]可选，必须使用8进制数，默认600(=384)，表示每个目录下最多保存的会话文件数量。
> 这是一个提高大量会话性能的好主意。
> 注意0: "N[MODE]/path"两边的双引号不能省略。
> 注意1: [MODE]并不会改写进程的umask。
> 注意2: php不会自动创建这些文件夹结构。请使用ext/session目录下的mod_files.sh脚本创建。
> 注意3: 如果该文件夹可以被不安全的用户访问(比如默认的"/tmp")，那么将会带来安全漏洞。
> 注意4: 当N>0时自动垃圾回收将会失效，具体参见下面有关垃圾搜集的部分。
>
>
>
>session.name = "PHPSESSID"
>用在cookie里的会话ID标识名，只能包含字母和数字。
>
>
>
>session.auto_start = Off
> 在客户访问任何页面时都自动初始化会话，默认禁止。
> 因为类定义必须在会话启动之前被载入，所以若打开这个选项，你就不能在会话中存放对象。
>
>
>
>session.serialize_handler = "php"
> 用来序列化/解序列化数据的处理器，php是标准序列化/解序列化处理器。
> 另外还可以使用"php_binary"。当启用了WDDX支持以后，将只能使用"wddx"。
>
>
>
>session.gc_probability = 1
>session.gc_divisor = 100
> 定义在每次初始化会话时，启动垃圾回收程序的概率。
> 这个收集概率计算公式如下：session.gc_probability/session.gc_divisor
> 对会话页面访问越频繁，概率就应当越小。建议值为1/1000~5000。
>
>
>
>session.gc_maxlifetime = 1440
> 超过此参数所指的秒数后，保存的数据将被视为'垃圾'并由垃圾回收程序清理。
> 判断标准是最后访问数据的时间(对于FAT文件系统是最后刷新数据的时间)。
> 如果多个脚本共享同一个session.save_path目录但session.gc_maxlifetime不同，
> 那么将以所有session.gc_maxlifetime指令中的最小值为准。
> 如果使用多层子目录来存储数据文件，垃圾回收程序不会自动启动。
> 你必须使用一个你自己编写的shell脚本、cron项或者其他办法来执行垃圾搜集。
> 比如，下面的脚本相当于设置了"session.gc_maxlifetime=1440" (24分钟)：
> cd /path/to/sessions find -cmin +24 | xargs rm
>
>
>
>session.referer_check =
> 如果请求头中的"Referer"字段不包含此处指定的字符串则会话ID将被视为无效。
> 注意：如果请求头中根本不存在"Referer"字段的话，会话ID将仍将被视为有效。
> 默认为空，即不做检查(全部视为有效)。
>
>
>
>session.entropy_file = "/dev/urandom"
> 附加的用于创建会话ID的外部高熵值资源(文件)，
> 例如UNIX系统上的"/dev/random"或"/dev/urandom"
>
>
>
>session.entropy_length = 0
> 从高熵值资源中读取的字节数(建议值：16)。
>
>
>
>session.use_cookies = On
> 是否使用cookie在客户端保存会话ID
>
>
>
>session.use_only_cookies = Off
> 是否仅仅使用cookie在客户端保存会话ID
> 打开这个选项可以避免使用URL传递会话带来的安全问题。
> 但是禁用Cookie的客户端将使会话无法工作。
>
>
>
>session.cookie_lifetime = 0
> 传递会话ID的Cookie有效期(秒)，0 表示仅在浏览器打开期间有效。
>
>
>
>session.cookie_path = "/"
> 传递会话ID的Cookie作用路径。
>
>
>
>session.cookie_domain =
> 传递会话ID的Cookie作用域。
> 默认为空表示表示根据cookie规范生成的主机名。
>
>
>
>session.cookie_secure = Off
> 是否仅仅通过安全连接(https)发送cookie。
>
>
>
>session.cookie_httponly = Off
> 是否在cookie中添加httpOnly标志(仅允许HTTP协议访问)，
> 这将导致客户端脚本(JavaScript等)无法访问该cookie。
> 打开该指令可以有效预防通过XSS攻击劫持会话ID。
>
>
>
>session.cache_limiter = "nocache"
> 设为{nocache|private|public}以指定会话页面的缓存控制模式，
> 或者设为空以阻止在http应答头中发送禁用缓存的命令。
>
>
>
>session.cache_expire = 180
> 指定会话页面在客户端cache中的有效期限(分钟)
> session.cache_limiter=nocache时，此处设置无效。
>
>
>
>session.use_trans_sid = Off
> 是否使用明码在URL中显示SID(会话ID)。
> 默认是禁止的，因为它会给你的用户带来安全危险：
> 1- 用户可能将包含有效sid的URL通过email/irc/QQ/MSN…途径告诉给其他人。
> 2- 包含有效sid的URL可能会被保存在公用电脑上。
> 3- 用户可能保存带有固定不变sid的URL在他们的收藏夹或者浏览历史纪录里面。
> 基于URL的会话管理总是比基于Cookie的会话管理有更多的风险，所以应当禁用。
>
>
>
>session.bug_compat_42 = On
>session.bug_compat_warn = On
> PHP4.2之前的版本有一个未注明的"BUG"：
> 即使在register_globals=Off的情况下也允许初始化全局session变量，
> 如果你在PHP4.3之后的版本中使用这个特性，会显示一条警告。
> 建议关闭该"BUG"并显示警告。
>
>
>
>session.hash_function = 0
> 生成SID的散列算法。SHA-1的安全性更高一些
> 0: MD5 (128 bits)
> 1: SHA-1 (160 bits)
> 建议使用SHA-1。
>
>
>
>session.hash_bits_per_character = 4
> 指定在SID字符串中的每个字符内保存多少bit，
> 这些二进制数是hash函数的运算结果。
> 4: 0-9, a-f
> 5: 0-9, a-v
> 6: 0-9, a-z, A-Z, "-", ","
> 建议值为 5
>
>url_rewriter.tags = "a=href,area=href,frame=src,form=,fieldset="
> 此指令属于PHP核心部分，并不属于Session模块。
> 指定重写哪些HTML标签来包含SID(仅当session.use_trans_sid=On时有效)
> **form和fieldset比较特殊：
>** 如果你包含他们，URL重写器将添加一个隐藏的"<input>"，它包含了本应当额外追加到URL上的信息。
> 如果要符合XHTML标准，请去掉form项并在表单字段前后加上<fieldset>标记。
> **注意：所有合法的项都需要一个等号(即使后面没有值)。
>** 推荐值为"a=href,area=href,frame=src,input=src,form=fakeentry"。

## (二)、文件

### 1、基础

#### (1)、当前路径问题(./)

==./==代表的是当前cli所在目录路径，而不是当前文件目录路径

>
>
>c:\code\helper\test\t.php
>
>```php
><?php
>    echo realpath('.');
>```
>
>***
>
>cli：c:\code\helper
>
>```shell
>> php test/t.php
>//输出结果是   c:\code\helper
>```
>
>***
>
>cli:c:\code\helper\test
>
>```shell
>> php t.php
>//输出结果是   c:\code\helper\testr
>```





**Warning**

在区分二进制文件和文本文件的系统上（如     Windows）打开文件时，[fopen()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.fopen.html) 函数的 mode 参数要加上 'b'。 

> 如果只是想将一个文件的内容读入到一个字符串中，用     [file_get_contents()](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/function.file-get-contents.html)，它的性能比上面的代码(fread/stream_get_contents)好得多。 

| 序号 | 函数/常量           | 本地文件 | 远程文件        | 不存在的文件    | 备注                                      |
| ---- | ------------------- | -------- | --------------- | --------------- | ----------------------------------------- |
| 1    | is_file/file_exists | true     | false           | false           | 注意系统字符编码                          |
| 2    | filesize            | int      | false+E_WARNING | false+E_WARNING | 建议文件==小于2GB==<br>可用@屏蔽E_WARNING |
| 3    | fopen               | source   | source          | false+E_WARNING | 可用@屏蔽E_WARNING                        |
| 4    |                     |          |                 |                 |                                           |
| 5    |                     |          |                 |                 |                                           |
| 6    |                     |          |                 |                 |                                           |
| 7    |                     |          |                 |                 |                                           |

| 序号 | mode | 功能 | 指针位置 | 创建文件     | 备注                                       |
| ---- | ---- | ---- | -------- | ------------ | ------------------------------------------ |
| 1    | `r`  | 读   | 头       | 否           |                                            |
| 2    | `r+` | 读写 | 头       | 否           |                                            |
| 3    | `w`  | 写   | 头       | 不存在则新建 |                                            |
| 4    | `w+` | 读写 | 头       | 不存在则新建 |                                            |
| 5    | `a`  | 写   | 末尾     | 不存在则新建 |                                            |
| 6    | `a+` | 读写 | 末尾     | 不存在则新建 |                                            |
| 7    | `x`  | 写   | 头       | 必须新建     | 如果文件已存在，<br>返回false+E_WARNING    |
| 8    | `x+` | 读写 | 头       | 必须新建     | 如果文件已存在，<br>返回false+E_WARNING    |
| 9    | `c`  |      |          |              |                                            |
| 10   | `c+` |      |          |              |                                            |
|      |      |      |          |              |                                            |
| 1    | `t`  |      |          | Windows      | 透明地将 \n 转换为 \r\n                    |
| 2    | `b`  |      |          | Windows      | 强制使用二进制模式，<br>这样就不会转换数据 |

在操作二进制文件时如果没有指定 'b' 标记，可能会碰到一些奇怪的问题，包括坏掉的图片文件以及关于 \r\n 字符的奇怪问题。 







### 2、读文件

### 3、写文件

### 4、从浏览器上传到我方服务器

#### (1)、post上传

>核心函数
>
>```php
>move_uploaded_file($tmp_name, $destination):bool
>//如果目标文件已经存在，将会被覆盖。
>```



##### a、上传单个文件



>```html
><form action="index.php" method="post"  enctype="multipart/form-data">
>    <input type="file"  name="input_name"></input>
>    <button type="submit">提交</button>
></form>
>```



>```PHP
>var_dump($_FILES);
>[
>   'input_name' => [
>       'name' => '5KHL6EHM0UQ20001.jpg',          #原图片的名称
>       'type' => 'image/jpeg',                    #原图片的格式
>       'tmp_name' => 'C:\wamp64\tmp\php4199.tmp', #服务器上的临时文件(通常在web服务器的日志目录中) 
>       'error' => 0,                              #上传过程是否有错
>       'size'=>244836                             #文件的大小，单位b    
>   ]
>]
>```



##### b、上传多个文件

###### (I)、input的name是数组(多个input)

>```html
><form action="index.php" method="post"  enctype="multipart/form-data">
>    <input type="file" name="input_name[a]" /><br>
>    <input type="file" name="input_name[b]" /><br>
>    <button type="submit">提交</button>
></form>
>```



>```php
>var_dump($_FILES);
>[
>    'input_name'=>[
>        'name' => [
>            'a' => 'timg (1).jpg',
>            'b' => 'timg (2).jpg'
>        ],
>        'type' => [
>            'a' => 'image/jpeg',
>            'b' => 'image/jpeg'
>        ],
>        'tmp_name' => [
>            'a' => 'C:\wamp64\tmp\phpAB9.tmp',
>            'b' => 'C:\wamp64\tmp\phpABA.tmp'
>        ],
>        'error' => [
>            'a' => 0,
>            'b' => 0
>        ],
>        'size' => [
>            'a' => 258939,
>            'b' => 258939
>        ]
>    ]
>    
>]
>```

###### (II)、input带multiple

> ```html
> <form action="./index.php" method="post" enctype="multipart/form-data">
>     <input type="file" name="input_name[]" multiple="multiple">
>     <button type="submit">提交</button>
> </form>
> ```



>```php
>var_dump($_FILES);
>[
>    'input_name'=>[
>        'name' => [
>            0 => 'timg (1).jpg',
>            1 => 'timg (2).jpg'
>        ],
>        'type' => [
>            0 => 'image/jpeg',
>            1 => 'image/jpeg'
>        ],
>        'tmp_name' => [
>            0 => 'C:\wamp64\tmp\phpAB9.tmp',
>            1 => 'C:\wamp64\tmp\phpABA.tmp'
>        ],
>        'error' => [
>            0 => 0,
>            1 => 0
>        ],
>        'size' => [
>            0 => 258939,
>            1 => 258939
>        ]
>    ] 
>]
>```





#### (2)、系统参数

##### a、系统常量



>这里的error具体参考值：文档 > 特点 > 文件上传处理 >  错误信息说明
>
>| 常量                        | 数字 | 解释                                                         |
>| --------------------------- | ---- | ------------------------------------------------------------ |
>| **`UPLOAD_ERR_OK`**         | 0    | 没错，成功                                                   |
>| **`UPLOAD_ERR_INI_SIZE`**   | 1    | 超限了。php.ini 中 [upload_max_filesize](https://www.php.net/manual/zh/ini.core.php#ini.upload-max-filesize) |
>| **`UPLOAD_ERR_FORM_SIZE`**  | 2    | 上传文件的大小超过了 HTML 表单中 *MAX_FILE_SIZE* 选项指定的值 |
>| **`UPLOAD_ERR_PARTIAL`**    | 3    | 文件只有部分被上传                                           |
>| **`UPLOAD_ERR_NO_FILE`**    | 4    | 没有文件被上传。                                             |
>| **`UPLOAD_ERR_NO_TMP_DIR`** | 6    | 找不到临时文件夹                                             |
>| **`UPLOAD_ERR_CANT_WRITE`** | 7    | 文件写入失败                                                 |

##### b、php.ini配置







### 5、我方服务器从第三方拉取文件

### 6、我方服务器向浏览器提供下载文件

## (三)、数学精度计算

### 1、bc函数

| 序号 | 函数                         | 功能       | 备注                     |
| ---- | ---------------------------- | ---------- | ------------------------ |
| 1    | `bcscale($scale)`            | 小数精度   |                          |
| 2    | `bcadd($x, $y, $scale=0)`    | 加         | 5+3=8                    |
| 3    | `bcsub($x, $y, $scale=0)`    | 减         | 5-3=2                    |
| 4    | `bcmul($x, $y, $scale=0)`    | 乘         | 5*3=15                   |
| 5    | `bcdiv($x, $y, $scale=0)`    | 除         | 5/3=1                    |
| 6    | `bcmod($x, $y, $scale=0)`    | 求余       | 5%3=2                    |
| 7    | `bcpow($x, $y, $scale=0)`    | 求幂       | 5**3=125                 |
| 8    | `bcsqrt($number, $scale)`    | 开二次方根 | 根号5=2                  |
| 9    | `bccomp($x, $y, $scale=0)`   | 比较大小   | `[1,0,-1]` bccomp(5,3)=1 |
| 10   | `bcpowmod($x, $y, $scale=0)` |            |                          |



## (四)、http请求

### 1、curl

#### (1)、核心流程

>```php
>function curlFun(){
>    //步骤一：打开curl资源
>    $resource = curl_init();
>    //步骤二：设置http协议参数
>    curl_setopt($resource, 'option', 'option-value');
>    //步骤三：执行请求
>    $result = curl_exec($resource);
>    //步骤四：关闭资源
>    curl_close($resource);
>    return $result;
>}
>```



#### (2)、常用选项option

| 等待 | key                           | value-type   | 解释                                                         | 备注 |
| ---- | ----------------------------- | ------------ | ------------------------------------------------------------ | ---- |
|      | CURLOPT_URL                   | string       |                                                              |      |
|      | CURLOPT_CUSTOMREQUEST         | string       | 请求method，get/post/head/delete等                           |      |
|      | CURLOPT_POST                  | bool         | TRUE 时会发送 POST 请求，类型为：application/x-www-form-urlencoded |      |
|      | CURLOPT_PUT                   | bool         | TRUE 时允许 HTTP 发送文件。要被 PUT 的文件必须在 CURLOPT_INFILE和CURLOPT_INFILESIZE 中设置 |      |
|      | CURLOPT_HTTPHEADER            | array        | 设置 HTTP 头字段的数组。格式： array('Content-type: text/plain', 'Content-length: 100') |      |
|      | CURLOPT_HEADER                | bool         | true:头文件的信息作为数据流输出                              |      |
|      | CURLOPT_RETURNTRANSFER        | bool         | true:将curl_exec()获取的信息以字符串返回，而不是直接输出     |      |
|      | CURLOPT_CONNECTTIMEOUT（_MS） | int          | 连接等待时间(秒/毫秒)                                        |      |
|      | CURLOPT_TIMEOUT（_MS）        | int          | 允许 cURL 函数执行的最长秒数(或毫秒)                         |      |
|      | CURLOPT_POSTFIELDS            | array/string | post的参数。array为键值对。string用ulencode风格(&)。文件路径前加@ |      |

#### (3)、相关函数

##### a、curl函数

| 序号 | 函数                                                         | 功能                                           | 备注             |
| ---- | ------------------------------------------------------------ | ---------------------------------------------- | ---------------- |
| 1    | `curl_version([ int $age = CURLVERSION_NOW] ) : array`       | cURL版本号                                     |                  |
| 2    | `curl_init([ string $url = NULL] ) : resource`               | 初始化                                         |                  |
| 3    | `curl_copy_handle( resource $ch) : resource`                 | 复制cURL会话和选项                             |                  |
| 4    | `curl_pause( resource $ch, int $bitmask) : int`              | 暂停和取消暂停cURL会话                         | CURLPAUSE_* 常量 |
| 5    | `curl_reset( resource $ch) : void`                           | 重置所有选项                                   |                  |
| 6    | `curl_setopt( resource $ch, int $option, mixed $value) : bool` | 设置选项                                       |                  |
| 7    | `curl_setopt_array( resource $ch, array $options) : bool`    | 设置选项                                       |                  |
| 8    | `curl_exec( resource $ch) : mixed`                           | 执行                                           |                  |
| 9    | `curl_close( resource $ch) : void`                           | 关闭                                           |                  |
| 10   | `curl_errno( resource $ch) : int`                            | 错误编码(上一次)                               |                  |
| 11   | `curl_strerror( int $errornum) : string`                     | 错误码转换错误信息                             |                  |
| 12   | `curl_error( resource $ch) : string`                         | 错误的字符串(最后一次)                         |                  |
| 13   | `curl_getinfo( resource $ch[, int $opt = 0] ) : mixed`       | 获取cURL会话连接的信息                         |                  |
| 14   | `curl_file_create`                                           | 此函数是该函数的别名： CURLFile::__construct() |                  |
| 15   | `curl_escape( resource $ch, string $str) : string`           | 对str进行URL编码转化                           |                  |
| 16   | `curl_unescape( resource $ch, string $str) : string`         | 对str进行URL编码反转化                         |                  |
|      |                                                              |                                                |                  |
| 1    | `curl_share_init( void) : resource`                          | 初始化一个 cURL 共享句柄                       |                  |
| 2    | `curl_share_setopt( resource $sh, int $option, string $value) : bool` | 设置选项                                       |                  |
| 3    | `curl_share_close( resource $sh) : void`                     | 关闭                                           |                  |
| 4    | `curl_share_errno( resource $sh) : int`                      | 错误编码(上一次)                               |                  |
| 5    | `curl_share_strerror( int $errornum) : string`               | 错误码转换错误信息                             |                  |
|      |                                                              |                                                |                  |
| 1    | `curl_multi_init( void) : resource`                          | 初始化批量cURL会话                             |                  |
| 2    | `curl_multi_add_handle( resource $mh, resource $ch) : int`   | 追加一个cURL会话                               |                  |
| 3    | `curl_multi_remove_handle( resource $mh, resource $ch) : int` | 删除某个cURL会话                               |                  |
| 4    | `curl_multi_select( resource $mh[, float $timeout = 1.0] ) : int` | 阻塞直到cURL批处理连接中有活动连接。           |                  |
| 5    | `curl_multi_setopt( resource $mh, int $option, mixed $value) : bool` | 设置选项                                       |                  |
| 6    | `curl_multi_exec( resource $mh, int &$still_running) : int`  | 执行                                           |                  |
| 7    | `curl_multi_close( resource $mh) : void`                     | 关闭                                           |                  |
| 8    | `curl_multi_errno( resource $mh) : int`                      | 错误码(上一次)                                 |                  |
| 9    | `curl_multi_strerror( int $errornum) : string`               | 错误码转换错误信息                             |                  |
| 10   | `curl_multi_getcontent( resource $ch) : string`              | 获取输出文本。前提：returntransfer             |                  |
| 11   | `curl_multi_info_read( resource $mh[, int &$msgs_in_queue = NULL] ) : array` | 获取当前解析的cURL的相关传输信息               |                  |

##### b、curlfile类

| 序号 | 方法                                                         | 功能                          | 备注 |
| ---- | ------------------------------------------------------------ | ----------------------------- | ---- |
| 1    | `__construct( string $filename[, string $mimetype[, string $postname]] )` | 创建 CURLFile 对象            |      |
| 2    | `getFilename( void) : string`                                | 获取被上传文件的 文件名       |      |
| 3    | `getMimeType( void) : string`                                | 获取被上传文件的 MIME 类型    |      |
| 4    | `getPostFilename( void) : string`                            | 获取 POST 请求时使用的 文件名 |      |
| 5    | `setMimeType( string $mime) : void`                          | 设置被上传文件的 MIME 类型    |      |
| 6    | `setPostFilename( string $postname) : void`                  | 设置 POST 请求时使用的文件名  |      |
| 7    | `__wakeup( void) : void`                                     | 反序列化句柄                  |      |

#### (4）、案例

##### a、网站

###### (I)、访问

>浏览器访问index.php。
>
>​                    会发现和打开www.baidu.com，界面上完全没事区别
>
>```php
>$ch = curl_init();
>curl_setopt($ch, CURLOPT_URL, "http://www.baidu.com/");
>curl_exec($ch);
>curl_close($ch);
>```



>多一个`curl_setopt($ch, CURLOPT_HEADER, true);`
>
>​	                  在界面上header被作为字符串输出了
>
>```php
>curl_setopt($ch, CURLOPT_URL, "http://www.baidu.com/");
>curl_setopt($ch, CURLOPT_HEADER, true);
>curl_exec($ch);
>curl_close($ch);
>```
>
>HTTP/1.1 200 OK Accept-Ranges: bytes Cache-Control: no-cache Connection: keep-alive Content-Length: 14615 Content-Type: text/html Date: Wed, 05 Aug 2020 07:33:19 GMT P3p: CP=" OTI DSP COR IVA OUR IND COM " P3p: CP=" OTI DSP COR IVA OUR IND COM " Pragma: no-cache Server: BWS/1.1 Set-Cookie: BAIDUID=8B76A08F7BDCCE2F7099AACD82C0426D:FG=1; expires=Thu, 31-Dec-37 23:55:55 GMT; max-age=2147483647; path=/; domain=.baidu.com Set-Cookie: BIDUPSID=8B76A08F7BDCCE2F7099AACD82C0426D; expires=Thu, 31-Dec-37 23:55:55 GMT; max-age=2147483647; path=/; domain=.baidu.com Set-Cookie: PSTM=1596612799; expires=Thu, 31-Dec-37 23:55:55 GMT; max-age=2147483647; path=/; domain=.baidu.com Set-Cookie: BAIDUID=8B76A08F7BDCCE2F5D50F97F15326061:FG=1; max-age=31536000; expires=Thu, 05-Aug-21 07:33:19 GMT; domain=.baidu.com; path=/; version=1; comment=bd Traceid: 1596612799023825255411033233847705283481 Vary: Accept-Encoding X-Ua-Compatible: IE=Edge,chrome=1



###### (II)、扒网站代码

>把百度首页扒下来放在a.html文件中
>
>```php
>$ch = curl_init("http://www.baidu.com/");
>$fp = fopen("a.html", "w");//a.html不一定早已存在
>
>curl_setopt($ch, CURLOPT_FILE, $fp);
>curl_setopt($ch, CURLOPT_HEADER, 0);
>
>curl_exec($ch);
>curl_close($ch);
>```
>
>

##### b、get请求

>
>
>```php
>function httpGet($url, $timeout = 30)
>{
>    $ch = curl_init();
>    curl_setopt($ch, CURLOPT_URL, $url);
>    curl_setopt($ch, CURLOPT_HEADER, 0);
>    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
>    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
>    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);//设置cURL允许执行的最长秒数。
>    $return = curl_exec($ch);
>    curl_close($ch);
>    return $return;
>}
>```
>
>

##### c、post请求

>```php
>function httpPost($url, $data, $timeout = 30)
>{
>    $ch = curl_init();
>    curl_setopt($ch, CURLOPT_URL, $url);
>    curl_setopt($ch, CURLOPT_POST, 1);
>    curl_setopt($ch, CURLOPT_HEADER, 0);
>    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
>    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
>    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
>    $result = curl_exec($ch);
>    curl_close($ch);
>    return $result;
>}
>```



##### 更多案例

###### onesignal-create-app

>官方文档：https://documentation.onesignal.com/reference/create-an-app
>
>```php
>    public function actionTt(){
>        $url = "https://onesignal.com/api/v1/apps";
>        $headers = [
>            'host:onesignal.com',
>            'Accept:application/json',
>            'Authorization:Basic OTg1M2MzMDgtYjBlNS00N2I2LTliOWEtZWU0N2FhYjQzOWRm'
>        ];
>        $data = [
>            'name' => 'test-20201211-104',
>            'site_name' => 'shopping',
>            'chrome_web_origin' => 'https://shopping-now-now.myshopify.com',
>            'chrome_web_default_notification_icon' => 'https://cdn.shopifycdn.net/s/files/1/0013/2710/4049/files/banner_45aeda53-2d1d-4f5e-a593-b04e51405228_1080x.png?v=1547635011',
>            'organization_id' => 'd0f61b1c-7dce-4a23-8ae7-aa73093b1e20'
>        ];
>        $ch1 = curl_init ();
>        curl_setopt($ch1, CURLOPT_URL, $url);
>        curl_setopt($ch1, CURLOPT_POST, 1);
>        curl_setopt($ch1, CURLOPT_RETURNTRANSFER, 1);
>        curl_setopt($ch1, CURLOPT_CONNECTTIMEOUT, 60);
>        curl_setopt($ch1, CURLOPT_HTTPHEADER, $headers);
>        curl_setopt($ch1, CURLOPT_SSL_VERIFYPEER, FALSE);
>        curl_setopt($ch1, CURLOPT_SSL_VERIFYHOST, FALSE);
>        curl_setopt($ch1, CURLOPT_POSTFIELDS, $data);
>        $img_info = curl_exec($ch1);
>        curl_close($ch1);
>        $res = json_decode($img_info,true);
>        var_dump($res);
>    }
>```
>
>

## (五)、邮件发送

## (六)、国际时间

| 概念 | 解释                                          | 备注 |
| ---- | --------------------------------------------- | ---- |
| UTC  | 世界协调时间、标准时间。==当前世界主流。==    |      |
| GMT  | 格林尼治标准时间。曾经是世界主流              |      |
| CST  | 中央标准时间。各国中央==在UTC基础上==自己定的 |      |

* 为确保UTC与GMT相差不会超过0.9秒，在有需要的情况下会在==UTC内加上正或负闰秒==





时区格式？？？支持哪些？？

### 1、时间戳

getTime()

### 2、格式化时间

### 3、时间戳与格式化时间转化

### 系统参数

#### 系统常量

#### php.ini配置

| key             | value | 解释 | 备注 |
| --------------- | ----- | ---- | ---- |
| `date.timezone` |       |      |      |



## (七)、认证

### 1、http认证  

文档>特点>用PHP进行http认证

### 2、Oauth

 文档>函数参考>web服务>OAuth

## (八)、反射reflection



>|                      |                                      |                    |         |
>| -------------------- | ------------------------------------ | ------------------ | ------- |
>| ReflectionException  |                                      |                    |         |
>| Reflection           |                                      |                    |         |
>| Reflector(Interface) | ReflectionClass                      | ReflectionObject   |         |
>| \|                   | ReflectionFunctionAbstract(abstract) | ReflectionFunction |         |
>| \|                   | \|                                   | ReflectionMethod   |         |
>| \|                   | ReflectionParameter                  |                    |         |
>| \|                   | ReflectionProperty                   |                    |         |
>| \|                   | ReflectionExtension                  |                    |         |
>| \|                   | ReflectionZendExtension              |                    | 5.4     |
>| \|                   | ReflectionClassConstant              |                    | 7.1     |
>| ReflectionGenerator  |                                      |                    | 7.0     |
>| ReflectionType       | ReflectionNamedType                  |                    | 7.0/7.1 |
>| ReflectionReference  |                                      |                    | 7.4     |





| class结构 | b    | c    | d    |
| --------- | ---- | ---- | ---- |
| namespace |      |      |      |
| classname |      |      |      |
| extends   |      |      |      |
| interface |      |      |      |
|           |      |      |      |



### 1、ReflectionClass/Object(7.2.0)

使用

>```php
>$ref = new \ReflectionClass(\common\models\ShopifyShop::class);
>
>$oShop = new \common\models\ShopifyShop();
>$ref = new \ReflectionClass($oShop);
>```
>
>构造函数解析
>
>```php
>public ReflectionClass::__construct( mixed $argument)
>```
>
>- `argument`
>
>  既可以是包含类名的字符串（[string](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html)）也可以是对象（[object](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.object.html)）。 
>
>* 返回初始化完成后的 [ReflectionClass](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/class.reflectionclass.html) 实例。 
>* 如果要反射的 Class 不存在，抛出异常 ReflectionException

#### (1)、file

>| method              | return | 功能                    |
>| ------------------- | ------ | ----------------------- |
>| getFileName( void)  | string | class所在file的filename |
>| getStartLine( void) | int    | class所在file中的起始行 |
>| getEndLine( void)   | int    | class所在file中的结束行 |

#### (2)、namespace

> | method                  | return | 功能                             |
> | ----------------------- | ------ | -------------------------------- |
> | inNamespace( void)      | bool   | 判断这个class是否使用了namespace |
> | getNamespaceName( void) | string | 命名空间的名称                   |

#### (3)、classname

> | 方法                                      | ruturn | 功能                              | version |
> | ----------------------------------------- | ------ | --------------------------------- | ------- |
> | getDocComment( void)                      | string | 获取注释                          |         |
> | isAbstract( void)                         | bool   | 这个类是否是abstract              |         |
> | isInterface(void)                         | bool   | 这个类是否是一个interface         |         |
> | isTrait( void                             | bool   | 这个类是否是trait                 |         |
> | isFinal( void)                            | bool   | 这个类是否final                   |         |
> | isAnonymous( void)                        | bool   | 这个类是否是Anonymous(匿名类)     |         |
> |                                           |        |                                   |         |
> | isCloneable( void)                        | bool   | 这个类是否可复制                  |         |
> | isInstantiable( void)                     | bool   | 这个类是否可实例化                |         |
> |                                           |        |                                   |         |
> | isInternal( void)                         | bool   | 这个类是否由扩展或核心在内部定义  |         |
> | isUserDefined( void)                      | bool   | 这个类是否是用户定义的            |         |
> |                                           |        |                                   |         |
> | isIterable( void)                         | bool   | 这个类是否是迭代器                | 7.2.0   |
> | isIterateable( void)                      | bool   | 这个类是否可迭代                  |         |
> |                                           |        |                                   |         |
> | getName( void)                            | string | class类名                         |         |
> | getShortName( void)                       | string | class类名,不带namespace           |         |
> |                                           |        |                                   |         |
> | isInstance( object $object)               | bool   | 判断某个对象是否是这个class的实例 |         |
> | newInstance( mixed \$args[, mixed $...] ) | object | new class($args....)              |         |
> | newInstanceArgs([ array $args] )          | object | new class($args....),参数由kv映射 |         |
> | newInstanceWithoutConstructor( void)      | object | new class()。但是不会调construct  |         |
>
> 
>
> 获取class的修饰符
>
> ```php
> public ReflectionClass::getModifiers( void) : int
> /**
> ReflectionClass 修饰符 
>      ReflectionClass::IS_IMPLICIT_ABSTRACT   指示了类是一个抽象类（abstract），因为它有抽象（abstract）方法。 
>      ReflectionClass::IS_EXPLICIT_ABSTRACT   指示了类是一个抽象类（abstract），因为它已明确定义。 
>      ReflectionClass::IS_FINAL               指示这是一个 final 类。 
> */
> ```
>
> 

#### (4)、extends

>| method                       | ruturn          | 功能                     |
>| ---------------------------- | --------------- | ------------------------ |
>| isSubclassOf( string $class) | bool            | 这个类是否是$class的子类 |
>| getParentClass( void)        | ReflectionClass | 获取父类的reflection     |

#### (5)、interface

> 
>
> | method                                  | return                     | 功能                                   |
> | --------------------------------------- | -------------------------- | -------------------------------------- |
> | getInterfaceNames( void)                | array                      | 获取全部接口名称(包括继承)             |
> | getInterfaces( void)                    | array(interface=>refClass) | 获取全部接口对应的reflection(包括继承) |
> | implementsInterface( string $interface) | bool                       | 判断是否实现某个接口                   |

#### (6)、constant

>| method                               | return                  | 功能                             | version |
>| ------------------------------------ | ----------------------- | -------------------------------- | ------- |
>| hasConstant( string $name)           | bool                    | 判断常量是否已定义(不考虑可见性) |         |
>| getConstant( string $name)           | mixed                   | 获取某常量的值                   |         |
>| getConstants( void)                  | array                   | 获取全部常量k-v(不考虑可见性)    |         |
>| getReflectionConstant( string $name) | ReflectionClassConstant | 获取某个常量的reflection         | 7.1.0   |
>| getReflectionConstants( void)        | array                   | 获取全部常量的reflection         | 7.1.0   |

#### (7)、property

>| method                                                       | return             | 功能                                                     |
>| ------------------------------------------------------------ | ------------------ | -------------------------------------------------------- |
>| hasProperty( string $name)                                   | bool               | 判断属性是否已定义（忽略可见性、static）                 |
>| getDefaultProperties( void)                                  | array              | 获取类中有默认值的属性(包括继承，且不考虑可见性与static) |
>| getProperties([ int $filter] )                               | array              | 获取属性的reflection                                     |
>| getProperty( string $name)                                   | ReflectionProperty | 获取单个属性的reflection                                 |
>| getStaticProperties( void)                                   | array              | 获取static属性k-v（不考虑可见性）                        |
>| getStaticPropertyValue( string \$name[, mixed &$def_value] ) | mixed              | 获取某个static属性的值(只能获取public)*                  |



>* property修饰符
>  * ReflectionProperty::IS_STATIC     指示了 static 的属性。 
>  * ReflectionProperty::IS_PUBLIC     指示了 public 的属性。 
>  * ReflectionProperty::IS_PROTECTED  指示了 protected 的属性。 
>  * ReflectionProperty::IS_PRIVATE    指示了 private 的属性。
>
>* 多个filter可以用 | 或 OR 组合使用

#### (8)、construct

>```php
>public ReflectionClass::getConstructor( void) : ReflectionMethod
>```
>
>
>
>

#### (9)、trait

>返回 trait 别名的一个数组(k-新名，v-原名)
>
>```php
>public ReflectionClass::getTraitAliases( void) : array
>```
>
> 返回这个类所使用 traits 的名称的数组
>
>```php
>public ReflectionClass::getTraitNames( void) : array
>```
>
> 返回这个类所使用的 traits 数组(k-名称， v-ReflectionClass)
>
>```php
>public ReflectionClass::getTraits( void) : array
>```
>
>

#### (10)、method

> 判断method是否已定义（忽略可见性，大小写）
>
> ```php
> public ReflectionClass::hasMethod( string $name) : bool
> ```
>
> 
>
> 获取method的reflection
>
> ```php
> public ReflectionClass::getMethods([ int $filter] ) : array
> /**
> *method属性
>  ReflectionMethod::IS_PUBLIC     可见性
>  ReflectionMethod::IS_PROTECTED
>  ReflectionMethod::IS_PRIVATE
>  ReflectionMethod::IS_STATIC     静态 
>  ReflectionMethod::IS_ABSTRACT   抽象
>  ReflectionMethod::IS_FINAL      final
> 
> 多个filter可以用 | 或 OR 组合使用
> 
> */
> ```
>
> 
>
> 获取某个method的reflection
>
> ```php
> public ReflectionClass::getMethod( string $name) : ReflectionMethod
> ```
>
> 

#### (11)、extension

>| method                  | return              | 功能                      |
>| ----------------------- | ------------------- | ------------------------- |
>| getExtension( void)     | ReflectionExtension | 获取该class所在的扩展     |
>| getExtensionName( void) | string              | 获取该class所在的扩展名称 |
>
>```php
>$object = new ReflectionFunction(function(){});
>$ref = new \ReflectionClass($object);
>var_dump($ref->getExtensionName());//Reflection
>```



### 2、ReflectionProperty(7.4.0)

>property修饰符
>
>* ReflectionProperty::IS_STATIC     指示了 static 的属性。 
>* ReflectionProperty::IS_PUBLIC     指示了 public 的属性。 
>* ReflectionProperty::IS_PROTECTED  指示了 protected 的属性。 
>* ReflectionProperty::IS_PRIVATE    指示了 private 的属性。
>
>```php
>class Str
>{
>    public $length  = 5;
>}
>$prop = new ReflectionProperty('Str', 'length');
>```
>
>
>
>| method                                   | return          | 功能             | version |
>| ---------------------------------------- | --------------- | ---------------- | ------- |
>| getDeclaringClass( void)                 | ReflectionClass | 在哪个class中    |         |
>| getDocComment( void)                     | string          | 获取备注         |         |
>| getModifiers( void)                      | int             | 获取修饰符       |         |
>| getName( void)                           | string          | name             |         |
>| getType( void)                           | ReflectionType  | 数据类型         | 7.4.0   |
>| getValue([ object $object] )             | mixed           | value            |         |
>| hasType( void)                           | bool            | 是否申明数据类型 | 7.4.0   |
>| isDefault( void)                         | bool            | 是否申明默认数据 |         |
>| isInitialized([ object $object] )        | bool            | 是否已初始化     | 7.4.0   |
>| isPrivate( void)                         | bool            |                  |         |
>| isProtected( void)                       | bool            |                  |         |
>| isPublic( void）                         | bool            |                  |         |
>| isStatic( void)                          | bool            |                  |         |
>| setAccessible( bool $accessible)         | void            | 设置可见性       |         |
>| setValue( object \$object, mixed $value) | void            |                  |         |
>| setValue( mixed $value)                  | void            |                  |         |
>
>

### 3、ReflectionClassConstant(7.1.0)

>```php
>public ReflectionClassConstant::__construct( mixed $class, string $name)
>```



constant修饰符（和class.method一样）

* ReflectionMethod::IS_STATIC            指示一个方法是静态（static）的。
* ReflectionMethod::IS_PUBLIC           指示一个方法是 public 的。
* ReflectionMethod::IS_PROTECTED  指示一个方法是 protected 的。
* ReflectionMethod::IS_PRIVATE         指示一个方法是 private 的。
* ReflectionMethod::IS_ABSTRACT     指示一个方法是 abstract 的。
* ReflectionMethod::IS_FINAL             指示一个方法是 final 的。



>| method                                                       | return          | 功能                |
>| ------------------------------------------------------------ | --------------- | ------------------- |
>| getDeclaringClass( void)                                     | ReflectionClass | 在哪个class中定义的 |
>| getDocComment( void)                                         | string          |                     |
>| getModifiers( void)                                          | int             |                     |
>| getName( void)                                               | string          |                     |
>| getValue( void)                                              | mixed           |                     |
>| isPrivate( void)                                             | bool            |                     |
>| isProtected( void )                                          | bool            |                     |
>| isPublic( void)                                              | bool            |                     |
>| static export( mixed \$class, string \$name[, bool $return] ) | string          |                     |

### 4、ReflectionMethod/Function

#### (1)、ReflectionFunctionAbstract

>| method                               | return              | 功能                         |
>| ------------------------------------ | ------------------- | ---------------------------- |
>| getClosureScopeClass( void)          | ReflectionClass     |                              |
>| getClosureThis( void)                | object              | 返回本身的匿名函数           |
>| getDocComment( void)                 | string              | 返回注释                     |
>| getEndLine( void)                    | int                 |                              |
>| getStartLine( void)                  | int                 |                              |
>| getExtension( void)                  | ReflectionExtension |                              |
>| getExtensionName( void)              | string              |                              |
>| getFileName( void)                   | string              | 文件名字                     |
>| getName( void)                       | string              | 获取函数名称                 |
>| getShortName( void)                  | string              |                              |
>| getNamespaceName( void)              | string              | 获取命名空间                 |
>| inNamespace( void)                   | bool                | 是否使用命名空间             |
>| getNumberOfParameters( void)         | int                 | 获取参数数目                 |
>| getNumberOfRequiredParameters( void) | int                 | 获取必须输入参数个数         |
>| getParameters( void)                 | array(k=>RefParam)  | 获取参数                     |
>| getReturnType( void)                 | ReflectionType      | 返回类型                     |
>| hasReturnType( void)                 | bool                |                              |
>| getStaticVariables( void)            | array               | 获取静态变量                 |
>| isClosure( void)                     | bool                | 检查是否是匿名函数           |
>| isDeprecated( void)                  | bool                | 检查是否已经弃用             |
>| isGenerator( void)                   | bool                | 判断函数是否是一个生成器函数 |
>| isInternal( void)                    | bool                | 判断函数是否是内置函数       |
>| isUserDefined( void)                 | bool                | 检查是否是用户定义           |
>| isVariadic( void)                    | bool                |                              |
>| returnsReference( void)              | bool                | 检查是否返回参考信息         |

#### (2)、ReflectionMethod

>```php
>public ReflectionMethod::__construct( mixed $class, string $name)
>public ReflectionMethod::__construct( string $class_method)
>    
>class Counter
>{
>    private static $c = 0;
>    final public static function increment()
>    {
>        return ++self::$c;
>    }
>}
>$method = new ReflectionMethod('Counter', 'increment');
>```



* method修饰符（和const一样）
  * ReflectionMethod::IS_STATIC            指示一个方法是静态（static）的。
  * ReflectionMethod::IS_PUBLIC           指示一个方法是 public 的。
  * ReflectionMethod::IS_PROTECTED  指示一个方法是 protected 的。
  * ReflectionMethod::IS_PRIVATE         指示一个方法是 private 的。
  * ReflectionMethod::IS_ABSTRACT     指示一个方法是 abstract 的。
  * ReflectionMethod::IS_FINAL             指示一个方法是 final 的。

>| method                                                       | return           | 功能                     |
>| ------------------------------------------------------------ | ---------------- | ------------------------ |
>| getDeclaringClass( void)                                     | ReflectionClass  | 在哪个class中            |
>| getClosure( object $object)                                  | Closure          | 获取这个method的匿名函数 |
>| getModifiers( void)                                          | int              | 修饰符                   |
>| getPrototype( void)                                          | ReflectionMethod | 返回方法原型 (如果存在)  |
>| invoke( object \$object[, mixed \$parameter[, mixed $...]] ) | mixed            |                          |
>| invokeArgs( object \$object, array $args)                    |                  |                          |
>| isAbstract( void)                                            | bool             |                          |
>| isConstructor( void)                                         | bool             |                          |
>| isDestructor( void)                                          | bool             |                          |
>| isFinal( void)                                               | bool             |                          |
>| isPrivate( void)                                             | bool             |                          |
>| isProtected( void)                                           | bool             |                          |
>| isPublic( void)                                              | bool             |                          |
>| isStatic( void)                                              | bool             |                          |
>| setAccessible( bool $accessible)                             | void             |                          |

#### (3)、ReflectionFunction

>
>
>```php
>public ReflectionFunction::__construct( mixed $name)
>    
>    
>function counter1()
>{
>    static $c = 0;
>    return ++$c;
>} 
>$ref = new ReflectionFunction('counter1'));
>```



>| method                                           | return  | 功能                     |
>| ------------------------------------------------ | ------- | ------------------------ |
>| getClosure( void)                                | Closure | 获取这个method的匿名函数 |
>| invoke([ mixed $...] )                           | mixed   |                          |
>| invokeArgs( array $args)                         | mixed   |                          |
>| isDisabled( void)                                | bool    |                          |
>| static export( string \$name[, string $return] ) |         |                          |

#### (4)、ReflectionParameter（5.6.0）

>```php
>public ReflectionParameter::__construct( callable $function, mixed $parameter)
>    
>$ref = new ReflectionParameter(array('className', 'methodName'), 'property');
>```

 



> | method                                                       | return                     | 功能                                                  |
> | ------------------------------------------------------------ | -------------------------- | ----------------------------------------------------- |
> | getClass( void)                                              | ReflectionClass            | 获得类型提示类                                        |
> | getDeclaringClass( void)                                     | ReflectionClass            | 这个参数是哪个类的                                    |
> | getDeclaringFunction( void)                                  | ReflectionFunctionAbstract | 这个参数是哪个method的                                |
> | getDefaultValue( void)                                       | mixed                      | 获取默认值                                            |
> | getDefaultValueConstantName( void)                           | string/exception           | 如果默认值是常量(全局或类常量)，返回value，否则抛异常 |
> | getName( void)                                               | string                     | 参数名                                                |
> | getPosition( void)                                           | int                        | 这个参数是第几个参数。0开始                           |
> | getType( void)                                               | ReflectionType             | 数据类型                                              |
> | hasType( void)                                               | bool                       | 是否强制类型                                          |
> | isArray( void)                                               | bool                       | 强制数组类型                                          |
> | isCallable( void)                                            | bool                       | 强制callable类型                                      |
> | isDefaultValueAvailable( void)                               | bool                       | 是否有默认值。                                        |
> | isDefaultValueConstant( void)                                | bool                       | 默认值是否是常量                                      |
> | allowsNull( void)                                            | bool                       | 是否允许null                                          |
> | canBePassedByValue( void)                                    | bool                       | 是否可传值                                            |
> | isOptional( void)                                            | bool                       | 是否是可选的                                          |
> | isPassedByReference( void)                                   | bool                       | 是否引用传值                                          |
> | isVariadic( void)                                            | bool                       | 是否是可变参数                                        |
> | export( string \$function, string \$parameter[, bool $return] ) | string                     |                                                       |
>
> 

### 5、ReflectionType/NameType

#### (1)、ReflectionType(7.0.0)

>类用于获取函数、类方法的参数或者返回值的类型。 
>
>| method            | return | 功能                       |
>| ----------------- | ------ | -------------------------- |
>| allowsNull( void) | bool   | 是否允许null               |
>| isBuiltin( void)  | bool   | 检查它是否为内置类型(或类) |



#### (2)、ReflectionNamedType(7.1.0)

>| method        | return | 功能             |
>| ------------- | ------ | ---------------- |
>| getName(void) | string | 返回类型提示文本 |

### 6、extension

#### (1)、ReflectionExtension

#### (2)、ReflectionZendExtension

### 7、ReflectionGenerator(7.0.0)

### 8、ReflectionReference(7.4.0)

## (九)、验证图和二维码

### 1、验证图

### 2、二维码

## (十)、操作mysql

链接pdo，增删改查

## (十一)、输出缓冲

ob_flush

## (十二)、socket

![微信图片_20200901182937](static/php/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20200901182937.jpg)



>
>
>　**a、client建立WebSocket时向服务器端请求的信息**
>
>　　GET /chat HTTP/1.1 
>　　Host: server.example.com 
>　　Upgrade: websocket //告诉服务器现在发送的是WebSocket协议
>　　Connection: Upgrade 
>　　Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw== //是一个Base64 encode的值，这个是浏览器随机生成的，用于验证服务器端返回数据是否是WebSocket助理
>　　Sec-WebSocket-Protocol: chat, superchat 
>　　Sec-WebSocket-Version: 13 
>　　Origin: http://example.com
>
>　　**b、服务器获取到client请求的信息后，根据WebSocket协议对数据进行处理并返回，其中要对Sec-WebSocket-Key进行加密等操作**
>
>　　HTTP/1.1 101 Switching Protocols 
>　　Upgrade: websocket //依然是固定的，告诉客户端即将升级的是Websocket协议，而不是mozillasocket，lurnarsocket或者shitsocket
>　　Connection: Upgrade 
>　　Sec-WebSocket-Accept: HSmrc0sMlYUkAGmm5OPpG2HaGWk= //这个则是经过服务器确认，并且加密过后的 Sec-WebSocket-Key,也就是client要求建立WebSocket验证的凭证
>　　Sec-WebSocket-Protocol: chat

## (十三)、生成器generator

> 返回【只有值】的生成器
>
> ```php
> function a($start, $end){
>     for($i = $start; $i <= $end; $i++){
>         yield $i;
>     }
> }
> 
> var_dump(a(1,3));//object(Generator)#2 (0) { }
> foreach (a(1,3) as $k=>$v){
>     echo $k.'=>'.$v.PHP_EOL;
> }
> /*
> 结果集：
> 0=>1
> 1=>2
> 2=>3
> */
> ```
>
> 返回【键=>值】的生成器
>
> ```php
> function a($start, $end){
>     for($i = $start; $i <= $end; $i++){
>         yield $i.'a' => $i . 'b';
>     }
> }
> 
> var_dump(a(1,3));//object(Generator)#2 (0) { }
> foreach (a(1,3) as $k=>$v){
>     echo $k.'=>'.$v.PHP_EOL;
> }
> /*
> 结果集：
> 1a => 1b
> 2a => 2b
> 3a => 3b
> */
> ```
>
> 中途注入参数
>
> ```php
> function a($start, $end){
>     for($i = $start; $i <= $end; $i++){
>         $injected = yield $i;
>         if($injected==3){
>             return 'stop';//因为外部注入中断。return用getReturn获取
>         }
>     }
> }
> 
> $generator = a(1,9);
> foreach ($generator as $v){
>     echo $v.PHP_EOL;
>     if($v==3) {
>         $generator->send($v);//中途注入参数
>         echo $generator->getReturn().PHP_EOL;//getReturn一定要确保有返回值，不要随便乱调用。会报错error
>     }
> }
> ```
>
> 

## (十四)、html中嵌入php

> - ->->[基本语法](http://docs.php.net/manual/zh/language.basic-syntax.php)->[从html中分离](http://docs.php.net/manual/zh/language.basic-syntax.phpmode.php)
> - [PHP 手册](https://www.php.net/manual/zh/index.php)->[语言参考](https://www.php.net/manual/zh/langref.php)->[流程控制](https://www.php.net/manual/zh/language.control-structures.php)->[流程控制的替代语法](https://www.php.net/manual/zh/control-structures.alternative-syntax.php)



# 五、swoole

## (一)、HTTP Server

## (二)、WebSocket Server

## (三)、TCP Server

## (四)、UDP Server

## (五)、Task

## (六)、Coroutine

## (七)、Channel

## (八)、Socket

## (九)、Stream

## (十)、MySQL

# 六、扩展

## (一)、操作系统相关

### 1、code运行服务器

#### (1)、识别当前服务器类型

> ```
> echo PHP_OS;//常量             Windows NT
> echo php_uname('s');//函数     WINNT  
> ```
>
> * 'a'：此为默认。包含序列 "s n r v m" 里的所有模式。
>
> * 's'：操作系统名称。例如： FreeBSD。
>
> * 'n'：主机名。例如： localhost.example.com。
>
> * 'r'：版本名称，例如： 5.1.2-RELEASE。
>
> * 'v'：版本信息。操作系统之间有很大的不同。
>
> *  'm'：机器类型。例如：i386。 

#### (2)、服务器差异性

| 序号 | 函数/常量           | window | linux | 备注             |
| ---- | ------------------- | ------ | ----- | ---------------- |
| 1    | DIRECTORY_SEPARATOR | `\`    | `/`   | 路径分隔符       |
| 2    | PHP_SHLIB_SUFFIX    | `dll`  | `so`  | 运行文件后缀     |
| 3    | PATH_SEPARATOR      | `;`    | `:`   | 多文件路劲分割符 |
| 4    | PHP_EOL             | `\r\n` | `\r`  | 换行标识         |

* PATH_SEPARATOR：include多个路径使用，在windows下，当你要include多个路径的话，你要用”;”隔开，但在linux下就使用”:”隔开的。

## amqp/rabbitmq

下载服务端： https://www.rabbitmq.com/download.html

下载客服端：https://www.rabbitmq.com/devtools.html

>- [php-amqplib](https://github.com/php-amqplib/php-amqplib)一个纯PHP，功能齐全的RabbitMQ客户端
>- [RabbitMqBundle](https://github.com/php-amqplib/rabbitmqbundle)将RabbitMQ消息传递与Symfony2 Web框架结合在一起
>- [PECL AMQP library](https://github.com/alanxz/rabbitmq-c)之上构建的[PECL AMQP库](http://pecl.php.net/package/amqp)
>- [VorpalBunny](https://github.com/myYearbook/VorpalBunny)使用[Rabbitmq_jsonrpc_channel](https://www.rabbitmq.com/plugins.html#rabbitmq_jsonrpc_channel)的PHP客户端库
>- [Thumper](https://github.com/php-amqplib/Thumper)消息传递模式库
>- [CAMQP](http://www.yiiframework.com/extension/amqp/)是Yii框架的扩展，为RabbitMQ消息传递提供了网关
>- [AMQP Interop](https://github.com/queue-interop/queue-interop#amqp-interop)是PHP中一组统一的AMQP 0-9-1接口及其实现



## opcode/APC/APCu/opcache

* 参考文档：
  * https://www.cnblogs.com/zhaoyixing/p/12635269.html
  * https://zhuanlan.zhihu.com/p/161441311
  * 





APC = APCu_bc,APC是旧名称，APCu_bc是当前名称

APC已经不维护了



APCu = APC User

APCu就是APC，但剔除了opcode缓存功能



Opcache通过将 PHP 脚本预编译的字节码存储到共享内存中来提升 PHP 的性能， 存储预编译字节码的好处就是 省去了每次加载和解析 PHP 脚本的开销

# 分门别类

## (一)、大小写问题

| 功能           | 区分大小写 | 举例                                            |
| -------------- | ---------- | ----------------------------------------------- |
| linux文件系统  | 严格区分   | a.txt和A.txt是两个文件                          |
| window文件系统 | 不区分     | a.txt和A.txt是一个文件                          |
|                |            |                                                 |
| 变量           | 严格区分   | `$var`和`$vaR`是两个变量                        |
| 常量           | 严格区分   | `define('aBc',1)`和`define('abc', 1)`时两个常量 |
| function       | 不区分     | `function aa`和`function Aa`相同                |
| 命名空间       | 不区分     | \ff\Test()和\Ff\Test()是相同的                  |
| 类名           | 不区分     | class aa{}和class AA{}是相同的                  |
| 类变量         | 严格区分   | 同变量                                          |
| 类常量         | 严格区分   | 同常量                                          |
| 类function     | 不区分     | 同function                                      |
| 魔术常量       | 不区分     | `___CLASS__`和`__class__`相同                   |
| array中的key   | 严格区分   | `['a'=>1, 'A'=>2]`数组中由两个不同元素          |

==简单归纳：==

* 只有==变量==、==常量==以及==key==严格区分大小写，其他是未强制要求的

## (二)、判断问题

==**文档 -> 附录 -> php类型比较表**==

* 使用 PHP 函数对变量 $x 进行比较
* 松散比较 ==
* 严格比较 ===
* (1\=='php')为false (0\=='php')为true

>```php
>$arr = [
>    null, 'null',   //空
>    0, '0',         //0
>    false, 'false', //false
>    '',
>    [],
>];
>
>/*********** == 判断 *********
> 
>'null'  => [0],
>'false' => [0],
>'0'     => [0, false],
>array() => [null, false]
>''      => [null, 0, false],
>null    => [0, false, '', array()],
>false   => [null, 0, '0', '', array()],
>0       => [null, 'null', '0',false, 'false', ''],//除了[]都==
>
>*/
>
>//特别注意 false != 'false'
>
>```

| 涉及场景                  | 什么等 | 举例 | 备注 |
| ------------------------- | ------ | ---- | ---- |
| 判断运算符`<=>`           | `==`   |      |      |
| switch..case              | `==`   |      |      |
| in_array()                | `==`   |      |      |
| in_array(field, [], true) | `===`  |      |      |



| 操作       | null | 'null' | 0    | '0'    | false | 'false' | ''     | []    | `var $x` |
| ---------- | ---- | ------ | ---- | ------ | ----- | ------- | ------ | ----- | -------- |
| gettype()  | null | string | int  | string | bool  | string  | string | array | null     |
| ?:         |      | true   |      |        |       | true    |        |       |          |
| empty      | true |        | true | true   | true  |         | true   | true  | true     |
| isset      |      | true   | true | true   | true  | true    | true   | true  |          |
| &&         |      | true   |      |        |       | true    |        |       |          |
| `if($var)` |      | true   |      |        |       | true    |        |       |          |

1、判断运算符`<=>`

>```php
>echo 3<=>1;//1
>echo 1<=>3;//-1
>echo 1<=>1;//0
>
>echo 3<=>'1';//1
>echo 1<=>'3';//-1
>echo 1<=>'1';//0
>```



## (三)、exist问题

| 判断的东西 | a               | b    |
| ---------- | --------------- | ---- |
| 变量       |                 |      |
| 常量       |                 |      |
| function   |                 |      |
| class      |                 |      |
| strait     |                 |      |
| interface  |                 |      |
| 类变量     | property_exists |      |
| 类常量     |                 |      |
| 类function |                 |      |

```php
class_alias ($original, $alias, $autoload = TRUE);
function_exists ($function_name);
interface_exists ($interface_name, $autoload = true);    
class_exists ($class_name, $autoload = true);
trait_exists($traitname, $autoload );
property_exists ($class, $property);
method_exists ($object, $method_name);
get_parent_class ($object = null);
get_called_class ();
get_class ($object = null);
is_subclass_of ($object, $class_name, $allow_string = TRUE);
is_a ($object, $class_name, $allow_string = FALSE);
get_class_vars ($class_name);
get_object_vars ($object);
get_class_methods ($class_name)


```



>
>
>```php
>class A{
>const aaa_bbb =333;
>}
>
>$a = 'aaa_bbb';
>
>//var_dump(A::$a);
>
>var_dump(constant("A3::".$a));
>var_dump(defined("A3::".$a));
>
>var_dump(defined('\common\services\OneSignalService::TEMPLATE_'.'TEST'));die;//true
>
>
>
>use common\services\OneSignalService;
>var_dump(defined('OneSignalService::TEMPLATE_'.'TEST'));die;//false
>```
>
>



## (四)、初始化赋值

| 序号 | 数据类型                               | 变量 | 变量static | 常量define | 常量const |      | 类变量 | 类变量static | 类常量const |
| ---- | -------------------------------------- | ---- | ---------- | ---------- | --------- | ---- | ------ | ------------ | ----------- |
| 1    | 不初始化                               |      | ==支持==   | 不支持     | 不支持    |      |        | ==支持==     | 不支持      |
| 2    | null                                   |      |            |            |           |      |        |              |             |
| 3    | boolean,string(单双)<br/>integer,float |      |            |            |           |      |        |              |             |
| 4    | 解释变量`"string{$x}"`                 |      | 不支持     |            | 不支持    |      | 不支持 | 不支持       | 不支持      |
| 5    | array                                  |      |            |            |           |      |        |              |             |
| 6    | callback                               |      | 不支持     | 不支持     | 不支持    |      | 不支持 | 不支持       | 不支持      |
| 7    | object                                 |      | 不支持     | 不支持     | 不支持    |      | 不支持 | 不支持       | 不支持      |
| 8    | resource                               |      | ?          | ?          | ?         |      | ?      | ?            | ?           |
| 9    | `+` `-` `*` `/` `%` `** `(1+2)         |      |            |            |           |      |        |              |             |
| 10   | `+` `-` `*` `/` `%` `** `(`$x`+`$y`)   |      | 不支持     |            | 不支持    |      | 不支持 | 不支持       | 不支持      |
| 11   | bcadd(1,2)                             |      | 不支持     |            | 不支持    |      | 不支持 | 不支持       | 不支持      |
| 12   | heredoc                                |      |            |            |           |      |        |              |             |
| 13   | nowdoc                                 |      |            |            |           |      |        |              |             |
| 14   | 常量                                   |      |            |            |           |      |        |              |             |
| 15   | 类变量                                 |      | 不支持     |            | 不支持    |      | 不支持 | 不支持       | 不支持      |
| 16   | 类静态变量                             |      | 不支持     |            | 不支持    |      | 不支持 | 不支持       | 不支持      |
| 17   | 类常量                                 |      |            |            |           |      |        |              |             |
| 18   | 类fuction                              |      | 不支持     |            | 不支持    |      | 不支持 | 不支持       | 不支持      |

### 1、变量

>```php
>class Obj{
>    public $oVar =111;
>    public static $oStaticVar = 222;
>    const O_CONST = 333;
>
>    public function method(){
>        return 444;
>    }
>}
>$obj = new  Obj();
>$x = 1;
>$y = 2;
>$z = 3;
>
>
>$a;                                     //1、仅声明不初始化
>$a = null;                              //2、null
>$a = false;                             //3、boolean,string(单双),integer,float
>$a = 'string';
>$a = "string";
>$a = 100;
>$a = 100.23;
>$a = "string{$z}";                       //4、解释变量
>$a = ['a' => 'a'];                       //5、array类型
>$a = function(){return 5;};              //6、callback
>$a = new stdClass();                     //7、object
>                                         //8、resource
>$a = 1+2;                                //9、+ - * / % **
>$a = $x+$y;                              //10、+ - * / % **（$x+$y）
>$a = bcadd(1,2);                         //11、bcadd()
>                                         //12、heredoc 13、nowdoc
>$a =<<<label
>here-doc
>label;
>$a = <<<'label'
>now-doc
>label;
>
>$a = PHP_INT_MAX;                        //14、常量
>
>$a = $obj->oVar;                         //15、类变量
>$a = Obj::$oStaticVar;                   //16、类静态变量
>$a = Obj::O_CONST;                       //17、类常量
>$a = $obj->method();                     //18、类function
>
>```
>
>

### 2、变量(static)

>
>
>```php
>class Obj{
>    public $oVar =111;
>    public static $oStaticVar = 222;
>    const O_CONST = 333;
>
>    public function method(){
>        return 444;
>    }
>}
>$obj = new  Obj();
>$x = 1;
>$y = 2;
>$z = 3;
>
>static $a;                                     //1、仅声明不初始化
>static $a = null;                              //2、null
>static $a = false;                             //3、boolean,string(单双),integer,float
>static $a = 'string';
>static $a = "string";
>static $a = 100;
>static $a = 100.23;
>static $a = "string{$x}";                       //4、解释变量
>static $a = ['a' => 'a'];                       //5、array类型
>static $a = function(){return 5;};              //6、callback
>static $a = new stdClass();                     //7、object
>                                                //8、resource
>static $a = 1+2;                                //9、+ - * / % **（1+2）
>static $a = $x+$y;                              //10、+ - * / % **（$x+$y）
>static $a = bcadd(1,2); //11、bcadd()
>                                                //12、heredoc 13、nowdoc
>static $a =<<<label
>here-doc
>label;
>static $a = <<<'label'
>now-doc
>label;
>
>static $a = PHP_INT_MAX;                        //14、常量
>
>static $a = $obj->oVar;                         //15、类变量
>static $a = Obj::$oStaticVar;                   //16、类静态变量
>static $a = Obj::O_CONST;                       //17、类常量
>static $a = $obj->method();                     //18、类function
>
>```
>
>





### 3、常量define()

>
>
>```php
>class Obj{
>    public $oVar=111;
>    public static  $oStaticVar =222;
>    const O_CONST=333;
>
>    function method(){
>        return 444;
>    }
>}
>$obj =new  Obj();
>
>$x= 1;
>$y= 2;
>$z= 3;
>
>$a;                                            //1、仅声明不初始化
>define('a', null);                              //2、null
>define('a', false);                             //3、boolean,string(单双),integer,float
>define('a', 'string');
>define('a', "string");
>define('a', 100);
>define('a', 100.23);
>define('a', "string{$x}");                       //4、解释变量
>define('a', ['a' => 'a']);                       //5、array类型
>define('a', function(){return 5;});              //6、callback
>define('a', new stdClass());                     //7、object
>                                                 //8、resource
>define('a', 1+2);                                //9、+ - * / % **（1+2）
>define('a', $x+$y);                              //10、+ - * / % **（$x+$y）
>define('a', bcadd(1,2)); //11、bcadd()
>                                                 //12、heredoc 13、nowdoc
>define('a', <<<label
>here-doc
>label);
>define('a', <<<'label'
>now-doc
>label);
>
>define('a', PHP_INT_MAX);                        //14、常量
>
>define('a', $obj->oVar);                         //15、类变量
>define('a', Obj::$oStaticVar);                   //16、类静态变量
>define('a', Obj::O_CONST);                       //17、类常量
>define('a', $obj->method());                     //18、类function
>var_dump(a);
>```
>
>



### 4、常量const

>
>
>```php
>class Obj{
>    public $oVar =111;
>    public const oStaticVar = 222;
>    const O_CONST = 333;
>
>    public function method(){
>        return 444;
>    }
>}
>$obj = new  Obj();
>$x = 1;
>$y = 2;
>$z = 3;
>
>const a;                                     //1、仅声明不初始化
>const a = null;                              //2、null
>const a = false;                             //3、boolean,string(单双),integer,float
>const a = 'string';
>const a = "string";
>const a = 100;
>const a = 100.23;
>const a = "string{$x}";                       //4、解释变量
>const a = ['a' => 'a'];                       //5、array类型
>const a = function(){return 5;};              //6、callback
>const a = new stdClass();                     //7、object
>                                                //8、resource
>const a = 1+2;                                //9、+ - * / % **（1+2）
>const a = $x+$y;                              //10、+ - * / % **（$x+$y）
>const a = bcadd(1,2); //11、bcadd()
>                                                //12、heredoc 13、nowdoc
>const a =<<<label
>here-doc
>label;
>const a = <<<'label'
>now-doc
>label;
>
>const a = PHP_INT_MAX;                        //14、常量
>
>const a = $obj->oVar;                         //15、类变量
>const a = Obj::$oStaticVar;                   //16、类静态变量
>const a = Obj::O_CONST;                       //17、类常量
>const a = $obj->method();                     //18、类function
>```
>
>





### 5、类变量

>
>
>```php
>class Obj{
>    public $oVar =111;
>    public static  $oStaticVar = 222;
>    const O_CONST= 333;
>
>    public function method(){
>        return 444;
>    }
>}
>$obj = new  Obj();
>
>class Test{
>public $x = 1;
>public $y = 2;
>public $z = 3;
>
>public $a;                                     //1、仅声明不初始化
>public $a = null;                              //2、null
>public $a = false;                             //3、boolean,string(单双),integer,float
>public $a = 'string';
>public $a = "string";
>public $a = 100;
>public $a = 100.23;
>public $a = "string{$this->x}";                       //4、解释变量
>public $a = ['a' => 'a'];                       //5、array类型
>public $a = function(){return 5;};              //6、callback
>public $a = new stdClass();                     //7、object
>                                                //8、resource
>public $a = 1+2;                                //9、+ - * / % **（1+2）
>public $a = $this->x+$this->y;                              //10、+ - * / % **（$x+$y）
>public $a = bcadd(1,2); //11、bcadd()
>                                                //12、heredoc 13、nowdoc
>public $a =<<<label
>here-doc
>label;
>public $a = <<<'label'
>now-doc
>label;
>
>public $a = PHP_INT_MAX;                        //14、常量
>
>public $a = $obj->oVar;                         //15、类变量
>public $a = Obj::$oStaticVar;                   //16、类静态变量
>public $a = Obj::O_CONST;                       //17、类常量
>public $a = $obj->method();                     //18、类function
>}
>```
>
>



### 6、类变量(static)

>
>
>```php
>class Obj{
>    public static $oVar =111;
>    public static $oStaticVar = 222;
>    public static $O_CONST= 333;
>
>    public function method(){
>        return 444;
>    }
>}
>$obj = new  Obj();
>
>class Test{
>public  $x = 1;
>public  $y = 2;
>public  $z = 3;
>
>public static $a;                                     //1、仅声明不初始化
>public static $a = null;                              //2、null
>public static $a = false;                             //3、boolean,string(单双),integer,float
>public static $a = 'string';
>public static $a = "string";
>public static $a = 100;
>public static $a = 100.23;
>public static $a = "string{$this->x}";                       //4、解释变量
>public static $a = ['a' => 'a'];                       //5、array类型
>public static $a = function(){return 5;};              //6、callback
>public static $a = new stdClass();                     //7、object
>                                                //8、resource
>public static $a = 1+2;                                //9、+ - * / % **（1+2）
>public static $a = $this->x+$this->y;                              //10、+ - * / % **（$x+$y）
>public static $a = bcadd(1,2); //11、bcadd()
>                                                //12、heredoc 13、nowdoc
>public static $a =<<<label
>here-doc
>label;
>public static $a = <<<'label'
>now-doc
>label;
>
>public static $a = PHP_INT_MAX;                        //14、常量
>
>public static $a = $obj->oVar;                         //15、类变量
>public static $a = Obj::$oStaticVar;                   //16、类静态变量
>public static $a = Obj::O_CONST;                       //17、类常量
>public static $a = $obj->method();                     //18、类function
>}
>```
>
>



### 7、类常量

>
>
>```php
>class Obj{
>    const oVar =111;
>    public const oStaticVar = 222;
>    const O_const = 333;
>
>    public function method(){
>        return 444;
>    }
>}
>$obj = new  Obj();
>
>class Test{
>public  $x = 1;
>public  $y = 2;
>public  $z = 3;
>
>const a;                                     //1、仅声明不初始化
>const a = null;                              //2、null
>const a = false;                             //3、boolean,string(单双),integer,float
>const a = 'string';
>const a = "string";
>const a = 100;
>const a = 100.23;
>const a = "string{$this->x}";                       //4、解释变量
>const a = ['a' => 'a'];                       //5、array类型
>const a = function(){return 5;};              //6、callback
>const a = new stdClass();                     //7、object
>                                                //8、resource
>const a = 1+2;                                //9、+ - * / % **（1+2）
>const a = $this->x+$this->y;                              //10、+ - * / % **（$x+$y）
>const a = bcadd(1,2); //11、bcadd()
>                                                //12、heredoc 13、nowdoc
>const a =<<<label
>here-doc
>label;
>const a = <<<'label'
>now-doc
>label;
>
>const a = PHP_INT_MAX;                        //14、常量
>
>const a = $obj->oVar;                         //15、类变量
>const a = Obj::$oStaticVar;                   //16、类静态变量
>const a = Obj::O_CONST;                       //17、类常量
>const a = $obj->method();                     //18、类function
>}
>```
>
>





















# php.ini

| 分类           | ini中key           | ini中value | 作用                   | 举例                                                         | 版本记录    |
| -------------- | ------------------ | ---------- | ---------------------- | ------------------------------------------------------------ | ----------- |
| 文件格式       | short_open_tag     |            | `<?..?>`               |                                                              |             |
|                | asp_tags           |            | `<%...%>`              |                                                              | ==7.0.0删== |
| 超全局变量     | variables_order    | EGPCS      | 设置超全局变量是否为空 | `$_ENV`     E<br>`$_GET`     G<br/> `$_POST`   P<br/>`$_COOKIE`C<br/> `$_SERVER` S |             |
|                | request_order      | GPC        | `$_REQUEST`            | get/post/cookie                                              |             |
| 预定义变量     | track_errors       | boolean    | `$php_errosmsg`        |                                                              | ==7.2.0删== |
|                | register_argc_argv | boolean    | `$argc` `$argv`        |                                                              |             |
| 执行运算符\`\` | safe_mode          | boolean    | 是否开启安全模式       |                                                              |             |



# 其他问题

## (一)、isset 判断是否存在且不为null

判断是否定义并初始化变量。

>```php
>$a;
>$b =null;
>$c =0;
>
>var_dump(isset($a));//false
>var_dump(isset($b));//false
>var_dump(isset($c));//true
>```

## (二)、file_exists和is_file文件明明在，确不存在

==此类问题常出现在windows==

根本原因是windows的中文系统使用的是GB字符集

解决方法：把文件路径转一下字符集

> ```php
> $filePath = iconv("UTF-8","GB2312//IGNORE",$filePath);
> ```
>
> 



## (三)、urlencode与rawurlencode

>
>
>为什么回去区分这个？
>
>因为js得urlencode与php要前后一致。不然解不出来
>
>| 函数         | 协议                                         | 功能                                                         |
>| ------------ | -------------------------------------------- | ------------------------------------------------------------ |
>| urlencode    |                                              | *-_.*    之外的所有非字母数字字符都将被替换成百分号（*%*）后跟两位十六进制数，空格则编码为加号（*+*）。 |
>| rawurlencode | [RFC 3986](http://www.faqs.org/rfcs/rfc3986) | *-_.*    之外的所有非字母数字字符都将被替换成百分号（*%*）后跟两位十六进制数 |
>
>* urlencode
>  * 此编码与 WWW    表单 POST 数据的编码方式是一样的，同时与    *application/x-www-form-urlencoded*    的媒体类型编码方式一样
>
>```php
><?php
>    $str = "a-b_c.d e*f/g=h?i&j,k ";
>echo urlencode($str);//a-b_c.d+e%2Af%2Fg%3Dh%3Fi%26j%2Ck
>echo rawurlencode($str);//a-b_c.d%20e%2Af%2Fg%3Dh%3Fi%26j%2Ck
>//只有空格得处理不同
>```



(四)、方法参数是callable.

>
>
>```php
>function myTest(callabel $f){
>    $f();
>}
>```
>
>

## call_user_func/call_user_func_array()



如何调用的：



>```php
>function myfun(){}
>
>class MyClass{
>	public function pubMethod(){}
>public static function pubStaticMethod(){}
>}
>    ```
>
>



## 理解continue和breake



>```php
>//如何正确理解continue和breake
>//1、在正常代码中会怎样
>
>echo 'a'.PHP_EOL;
>continue;
>echo 'b'.PHP_EOL;
>break;
>
>//2、在if、switch中会怎样(非循环控制体)
>
>if(true){
>echo "c".PHP_EOL;
>continue;
>	echo 'd'.PHP_EOL;
>    	break;
>    }
>
>```
>
>* ==( ! ) Fatal error: 'break' not in the 'loop' or 'switch' context in C:\code\index.php on line 5==
>* 也就是说break和continue必须在==循环体==或者==switch==中







# 代码逻辑

## 获取shop-info

> ```php
> /**
> *用户获取shop-info
> */
> public static function infoGet($shop, $field=''){
>     static $map = [];
>     if(isset($map[$shop])){
>         //一、内存(实时)
>         $data = $map[$shop];
>     }else{
>         $dataCache = RedisHelper::get(self::infoCacheKey($shop));
>         if($dataCache){
>             //二、内存(缓存)
>             $data = json_decode($dataCache, true);
>         }else{
>             //三、数据库
>             $data = self::infoCache($shop);
>         }
>     }
>     $map[$shop] = $data;
>     if($field){
>         return $data[$field] ?? false;
>     }else{
>         return $data;
>     }
> }
> /**
> *后台修改shop-info
> */
> public static function infoCacheReset($shop){
>     return self::infoCache($shop, true);
> }
> /**
> *缓存操作
> */
> private static function infoCache($shop, $resetCache = false, $lockTryTimes = 3){
>     $dataCacheTime =86400;
> 
>     $lockKey = "lock:info_{$shop}";
>     $lockTime = 10;//秒
>     //        $lockTryTimes = 3;//次数
>     $lockSleepTime = 100000;//十分之一秒（1百万微秒=1秒）
> 
>     if($resetCache || LockHelper::lock($lockKey, $lockTime)){//防止缓存穿透
>         //三、查数据库
>         $data = ShopifyShop::find()->where(['shop' => $shop])->asArray()->one();
>         RedisHelper::set(self::infoCacheKey($shop), json_encode($data), $dataCacheTime);
>         LockHelper::unlock($lockKey);
>     }else{
>         //查库被锁，等待查询结束
>         if($lockTryTimes){
>             usleep($lockSleepTime);
>             return self::infoCache($shop, $resetCache, $lockTryTimes - 1);
>         }else{
>             throw new \Exception('被锁请求次数耗尽',10000);
>         }
>     }
>     return $data;
> }
> private static function infoCacheKey($shop){
>     return "shop_info:{$shop}";
> }
> ```





# 易错坑位

## http_build_query

>空数组会被过滤
>
>```php
>echo "xxx".http_build_query(["a"=>[]]);
>//输出结果:xxx
>echo "xxx".http_build_query(["a"=>""]);
>//输出结果:xxxa=
>
>```

## 数组+运算和merge区别

>
>
>+运算，是对key求和，不是value
>
>```
>
>$a = ["b"];
>$b = ["c","d"];
>var_dump($a+$b);// b d
>```
>
>

## 函数array_merge小注意

>**array_merge()** 将一个或多个数组的单元合并起来，一个数组中的值附加在前一个数组的后面。返回作为结果的数组。     
>
>* 如果输入的数组中有相同的字符串键名，则该键名后面的值将覆盖前一个值。(后面的覆盖前面的)
>* 然而，如果数组包含数字键名，后面的值将*不会*覆盖原来的值，而是附加到后面。     
>* 如果只给了一个数组并且该数组是数字索引的，则键名会以连续方式重新索引。(数字索引会重排---字符串型数字也是数字索引)
>
>```php
>    $a = ["a"=>"b"];
>    $b = ["44"=>"c"];
>    var_dump(array_merge($a,$b));die;
>/**
>array(2) {
>  ["a"]=>
>  string(1) "b"
>  [0]=>
>  string(1) "c"
>}
>*/
>
>    $a = [3=>"a"];
>    $b = [3=>"d"];
>    var_dump(array_merge($a,$b));die;
>/**
>array(2) {
>  [0]=>
>  string(1) "a"
>  [1]=>
>  string(1) "d"
>}
>*/
>```
>
>

## strtotime[last month|-1 month]

>```php
>$day = "2021-07-31 12:12:12";
>echo date("Y-m-d H:i:s", strtotime("-1 month", strtotime($day))).PHP_EOL;
>echo date("Y-m-d H:i:s", strtotime("last month", strtotime($day))).PHP_EOL;
>echo date("Y-m-d H:i:s", strtotime("first day of last month", strtotime($day))).PHP_EOL;
>
>/*
>2021-07-01 12:12:12
>2021-07-01 12:12:12
>2021-06-01 12:12:12
>*/
>```
>
>





















