# 一、入门须知

## (一)、文件命名

以 .php  结尾

## (二)、文件格式

文件名  index.php

>```php
><?php
>echo "hello world";//我是注释
>//我是注释
>/*
>我也是注释
>我也是注释
>*/
>```



在linux的cli中运行   php index.php

==<?php ..... ?\>==是文件开始和结束标志，开始标志必须有，结束标志可以省略

* php.ini中short_open_tag改为短标签(缩写)\<? ?\>
* php.ini中asp_tags改为asp风格 <% %>==PHP 7.0.0. 中移除。==



## (三)、注释方式

### 1、单行注释

//

### 2、多行注释

/* ........*/

## (四)、行结束标志

==在PHP中以逗号作为一行的结束标志，不可省略。==

# 二、语法

## (一)、数据

### 1、数据类型

>4种标量：boolean、integer、float、string
>
>3种复合：array、object、callback
>
>2种特殊：resource、NULL
>
>1种不是数据类型：NaN

| 序号 | 类型     | 举例                     | 备注                                                         |
| ---- | -------- | ------------------------ | ------------------------------------------------------------ |
| 1    | boolean  | true\|false\|TRUE\|FALSE | 不区分大小写                                                 |
| 2    | integer  | -1\|0\|1                 | 支持2/8/10/16进制<br>10转2进制：`decbin($var)`<br/>10转8进制：`decoct($var)`<br/>10转16进制：`dechex($var)`<br/>2转10进制：`bindec($var)`<br/>8转10进制：`octdec($var)`<br/>16转10进制：`hexdec($var)`<br/>任意进制转换：`base_convert($number, $from, $to)` |
| 3    | float    | -1.0\|0.0\|1.0           |                                                              |
| 4    | string   | '123'\|'abcd'            | [string](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html) 最大可以达到 2GB。<br>==可以当作array进行字符修改与获取== |
| 5    | null     | null\|NULL               | 仅定义默认为null；<br>变量被unset()<br>==都会有警告提示 PHP Notice== |
| 6    | array    | array(1,'1')\|[1,'1']    | new 类名                                                     |
| 7    | object   | new StdClass()           |                                                              |
| 8    | callback | function(){}             | 执行:$var(参数)或者call_user_func(\$var,\$params)            |
| 9    | resource | file_open('filename')    | get_resource_type。某些文件或连接的句柄<br>文档附录：资源类型列表。有好几十中，比如：file，mysql，odbc，curl，fpt等 |

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
>$var8=function(){echo "hello world";}//callback
>$var9='';
>```

#### 细说数据类型

##### a、integer和int的精度与溢出问题。

* 如果给定的一个数超出了 [integer](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html) 的范围，将会被解释为    [float](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)。

>```php
>$var = PHP_INT_MAX;
>var_dump($var);//int
>var_dump($var+1);//float
>$var= PHP_INT_MIN;
>var_dump($var);//int
>var_dump($var-1);//float
>```



##### b、string

###### (I)、字符串==可以当作array==进行修改和读取单个字符

>```php
>//(汉字在utf-8中占三位，这样读取会乱码)
>echo $var4[0];//结果为a;
>$var4[0]=1;
>echo $var4;//结果为1bc
>```

###### (II)、字符串的四种定义方法：

>```php
>//1.单引号
>$var = 'abc';//不可解释变量和转义符(转义符只能转义单引号)
>//2.双引号
>$var = "abc";
>//3.nowdoc
>$var=<<<'label'//完全和单引号差不多
>    abc
>    label;
>//4.heredoc
>$var=<<<label
>    abc
>    label;
>```

##### c、array

==array中key严格区分大小写==            `['a'=>1, 'A'=>2]`数组中由两个不同元素

###### (I)、定义方式有两种

>```php
>$var = array(1,'a');
>$var = [1, 'a'];
>```

###### (II)、关联与非关联数组

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

###### (III)、把object强转化为array

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

##### d、resource

释放资源

   引用计数系统是 Zend 引擎的一部分，可以自动检测到一个资源不再被引用了（和     Java 一样）。这种情况下此资源使用的所有外部资源都会被垃圾回收系统释放。因此，很少需要手工释放内存。   

> ==Note==:     持久数据库连接比较特殊，它们*不会*被垃圾回收系统销毁。参见[数据库永久连接](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/features.persistent-connections.html)一章。    



#### (1)、类型强转换



| 序号 | 类型     | 强转换                     | 备注                                                         |
| ---- | -------- | -------------------------- | ------------------------------------------------------------ |
| 1    | boolean  | (bool)\|(boolean)          | 当转换为 [boolean](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html) 时，以下值被认为是 **`FALSE`**：   <br>[布尔](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html)值 **`FALSE`** 本身<br/>[整型](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html)值 0（零）<br/>[浮点型](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)值 0.0（零）<br/>空[字符串](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html)，以及[字符串](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html) "0"  <br/>不包括任何元素的[数组](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.array.html)<br/>特殊类型 [NULL](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.null.html)（包括尚未赋值的变量）<br/>从空标记生成的 [SimpleXML](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/ref.simplexml.html) 对象<br>所有其它值都被认为是 **`TRUE`**（==包括任何[资源](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 和  **`NAN`**==）。 |
| 2    | integer  | (int)\|(integer)\|intval() | 从boolen转换：false-0,true-1<br>从float转换：向下取整<br>NaN和Infinity转换：0     （==php7.0.0==）<br>从string转换：以数字(含科学计数)开头则数字，其他为0<br>==没有定义从其它类型转换为整型的行为。*不要*依赖任何现有的行为，因为它会未加通知地改变== |
| 3    | float    |                            |                                                              |
| 4    | string   | (string)\|strval()         | 从boolean值转换：false-0,true-1<br>从integer和float转换：对应字符串<br>从array转换：‘Array’字样<br>从object转换：‘Object’字样<br>从resource转换：‘Resource id #1'字样<br>从null转换：空字符串 |
| 5    | null     |                            |                                                              |
| 6    | array    | (array)\|array($var)       | 对于任意 [integer](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html)，[float](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)，[string](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html)，[boolean](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html)    和 [resource](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 类型转为array，将得到一个只有一个元素的数组<br>将 **`NULL`** 转换为 [array](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.array.html) 会得到一个空的数组<br>降object转为array：属性名为key，属性值为value |
| 7    | object   |                            | 如果其它任何类型的值被转换成对象，将会创建一个内置类    *stdClass* 的实例。<br>如果该值为    **`NULL`**，则新的实例为空。 <br>   [array](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.types.array.html) 转换成 [object](mk:@MSITStore:C:\Users\fff\Desktop\php_enhanced_zh.chm::/res/language.types.object.html) 将使键名成为属性名并具有相对应的值。<br>注意：在这个例子里， 使用 PHP 7.2.0 之前的版本，数字键只能通过迭代访问。 |
| 8    | callback |                            |                                                              |
| 9    | resource |                            | 无意义                                                       |



#### (3)、数据类型的系统参数

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

### 2、数据载体

| 载体名称 | 大小写   | 举例                         | 备注         |
| -------- | -------- | ---------------------------- | ------------ |
| 变量     | 严格区分 | `$var='v1';`<br>`$vaR='v2';` |              |
| 常量     | 严格区分 | `define("FOO","vvv");`       | 习惯统一大写 |



承载数据的东西。比如变量、常量等

#### (1)、变量

##### a、命名规则

>`[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*`    ==`$this`==这是一个特殊

==区分大小写==

##### b、预定义变量

| 序号 | 命令名称                | 分类         | 作用                            | 其他                         |
| ---- | ----------------------- | ------------ | ------------------------------- | ---------------------------- |
| 1    | `$GLOBALS`              | 超全局变量   | 全局作用域的可用全部变量        |                              |
| 2    | `$_ENV`                 | 超全局变量-E | shell环境变量                   | 由shell提供                  |
| 3    | `$_SERVER`              | 超全局变量-S | web服务器和执行环境信息         | 由web服务器提供              |
| 4    | `$_REQUEST`             | 超全局变量   | `$_GET` + `$_POST` + `$_COOKIE` | php.ini的request_order="GPC" |
| 5    | `$_GET`                 | 超全局变量-G | http-get                        |                              |
| 6    | `$_POST`                | 超全局变量-P | http-post                       |                              |
| 7    | `$_COOKIE`              | 超全局变量-C | cookie值                        |                              |
| 8    | `$_SESSION`             | 超全局变量   | session                         |                              |
| 9    | `$_FILES`               | 超全局变量   | http上传文件                    |                              |
| 10   | `$php_errormsg`         |              | 前一个错误信息                  | ==7.2.0删==                  |
| 11   | `$HTTP_RAW_POST_DATA`   |              | 原生post数据                    | ==5.6.0删==                  |
| 12   | `$http_response_header` |              | http响应头(局部作用域)          | 注意报错：未定义变量         |
| 13   | `$argc`                 |              | 传递给脚本的参数个数            | php.ini的register_argc_argv  |
| 14   | `$argv`                 |              | 传递给脚本的参数数组            |                              |

* ==超全局变量意味着它们在一个脚本的全部作用域中都可以被调用==
* 奇葩：`$GLOBALS['GLOBALS']['GLOBALS']['GLOBALS']`和`$GLOBALS`完全一样，而且不是错
* `$GLOBALS`中包含了全部的超全局变量(9种，包括它自己)
* php.ini中==variables_order==控制`$_ENV` `$_GET` `$_POST` `$_COOKIE` `$_SERVER`是否为空。EGPCS<br>正式环境建议`$_ENV`设为空，需要的时候使用getenv()调用

###### (I)、`$_GLOBALS`

>必定包含9个超全局变量，含自己

###### (II)、`$_ENV`

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
>  file_get_contents("http://example.com");
>  var_dump($http_response_header);//有值
>}
>get_contents();
>var_dump($http_response_header);//null  这里会报错，提示未定义
>```
>
>

##### c、特殊变量(可变变量)

>即变量的名称是可变的变量
>
>```php
>$a = 'var';
>$$a = 'value';
>echo $var;//value
>```
>
>

##### d、特殊变量(静态变量)

>设置值仅支持：
>
>* [boolean|integer|float|string|null|array]+已定义的常量。
>
>* 不支持调用，回调等方式，不支持heredoc。
>
>```php
>static $var=2;//???
>
>//如何调用？
>```
>
>

#### (2)、常量

##### a、命名规则

>`[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*`
>
>==区分大小写==
>
>习惯常量标识全部大写，比如：`define("PHP_INT_MAX", 222)`



##### b、预定义常量

这个有很多

##### c、特殊常量(魔术常量)

>这里都是根据==物理存储位置==决定的，与继承、引入文件等无关
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



## (二)、运算符

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

### 1、算术运算符

>```php
>$x=4;
>$y=2;
>```

| 序号 | 符号 | 作用       | 举例                                    | 备注                                            |
| ---- | ---- | ---------- | --------------------------------------- | ----------------------------------------------- |
| 1    | **   | 求幂       | `$x**$y=16`                             |                                                 |
| 2    | *    | 乘号       | `$x*$y=8`                               |                                                 |
| 3    | /    | 除号       | `$x/$y=2`                               |                                                 |
| 4    | %    | 求余(取模) | `$x%$y=0`                               |                                                 |
| 5    | -    | 取反       | `-$x=-4`                                | `-2-2=-4`                                       |
| 6    | -    | 减号       | `$x-$y=2`                               |                                                 |
| 7    | +    | 加号       | `$x+$y=6`                               |                                                 |
| 8    | ++   | 递增       | `echo ++$x;`输出5<br>`echo $x++;`输出4  | `++`在前，先+1再运算；<br>`++`在后，先运算再+1  |
| 9    | --   | 递减       | `echo --$x;`输出3<br/>`echo $x--;`输出4 | `--`在前，先-1再运算；<br/>`--`在后，先运算再-1 |

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

### 2、比较运算符

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

### 3、逻辑运算符

| 序号 | 符号 | 作用 | 举例        | 备注                                     |
| ---- | ---- | ---- | ----------- | ---------------------------------------- |
| 1    | and  | 且   |             |                                          |
| 2    | or   | 或   |             |                                          |
| 3    | xor  | 异或 | `$a xor $b` | `$a`和`$b`有且只有一个为true，结果才true |
| 4    | !    | 非   |             |                                          |
| 5    | &&   | 且   |             |                                          |
| 6    | \|\| | 或   |             |                                          |

### 4、位运算符

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

### 5、字符串运算符

>```php
>$a = 'a';
>$b = 'b';
>```

| 序号 | 符号 | 作用       | 举例                   | 备注                          |
| ---- | ---- | ---------- | ---------------------- | ----------------------------- |
| 1    | .    | 连接字符串 | `echo $a.$b;`输出ab    |                               |
| 2    | .=   | 连接字符串 | `echo $a .= $b;`输出ab | `$a.=$b`和`$b =$a.$b`完全相同 |

### 6、数组运算符

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

### 7、特殊运算符

| 序号 | 符号       | 作用             | 举例                         | 备注                                             |
| ---- | ---------- | ---------------- | ---------------------------- | ------------------------------------------------ |
| 1    | =          | 赋值             | `$x=1;`                      |                                                  |
| 2    | @          | 任何错误都被忽略 | `$x=@$_GET['x'];`            |                                                  |
| 3    | \`...`     | 执行运算符       | *echo \`ls -al\`;*           | php.ini的safe_mode<br>关闭了`shell_exec()`时无效 |
| 4    | instanceof | 判断类型         | `$var instanceof $className` | className带命名空间                              |



## (三)、流程控制

### 1、循环

#### (1)、for

#### (2)、while

#### (3)、do...while

#### (4)、foreach

(5)、

(6)、

### 2、判断

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

### 3、引入文件

#### (1)、include/include_once

#### (2)、require/require_once

### 4、异常

### 5、流程跳出和中断

#### (1)、continue

#### (2)、breake

### 6、其他

(1)、goto

(2)、declare

(3)、return

(4)、echo

## (四)、function

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



### 2、函数定义

#### (1)、普通定义

>```php
>function myfun(){ echo "hello world!";}
>```

#### (2)、条件定义

>```php
>$flag = rand(0, 1);
>if($flag){
>    function myFun(){ echo "hello world!";}
>}
>if($flag) {
>    myFun();//正常调用
>}else{
>    myFun();//报错，myFun未定义
>}
>```

#### (3)、函数中定义

>```php
>function outFun(){
>    function innerFun(){
>        echo 'hello world!';
>    }
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
>    var_dump($params);//['a', 'b', 'c', 'd', 'e', 'f']
>    var_dump(func_num_args());//6
>    var_dump(func_get_args());//['a', 'b', 'c', 'd', 'e', 'f']
>    var_dump(func_get_arg(2));//c
>}
>myFun('a', 'b', 'c', 'd', 'e', 'f');
>```
>
>

### 3、函数重载

>php不支持函数重载
>
>```php
>function myFun(){echo "hello world!";}
>function myFun($p1, $p2){echo "{$p1}--hello world!--{$p2}";}//报错，myFun已定义
>```

### 4、递归函数

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

## (五)、对象

### 概念

#### (1)、访问控制

>public          可以被任意访问
>
>protected   可以被当前类以及其子类调用
>
>private        仅限当前类调用
>
>当未定义访问控制时，默认是public
>
>仅属性(字段)、方法(函数)支持访问控制，类常量不需要
>
>```php
>public $var;
>public function myFun(){}
>const myCOnstant = '111';//不需要访问控制
>```
>
>

#### (2)、static(静态)

>仅属性(字段)、方法(函数)支持设置static(静态)，类常量不需要
>
>设置了static，不论是属性还是方法，一旦调用，就会存在内存中，直到本次请求结束
>
>设置了static的属性和方法，==调用方式[self|parent|className]::$var，不能用\$this调用。==
>
>设置值仅支持：
>
>* [boolean|integer|float|string|null|array]+已定义的常量。
>
>* 不支持调用，回调等方式，不支持heredoc。



>```php
>public static $var;
>public static function myFun(){}
>```

### 1、class

| 组成   | 定义                                       | 备注 |
| ------ | ------------------------------------------ | ---- |
| 属性   | [public\|private\|protected]+[static]+$var |      |
| 类常量 | const+constName                            |      |
| 方法   |                                            |      |

#### (1)、class的组成成分

##### a、属性(字段)

###### (I)、如何定义属性

>1. 访问控制  public/private/protected/无
>2.  是否静态 static/无
>
>```php
>$property;
>public $property;
>public static $property;
>```



###### (II)、定义属性并赋值举例：

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

###### (III)、调用方式

>```php
>//类内部调用
>echo $this->property;//$property         $object->property
>echo self::$property;//static $property  [self | parent | className]
>```
>
>

##### b、类常量

###### (I)、定义规则：

>1. 声明定义时必须赋值
>2. 类常量名称==不能使用\$==
>3. 不能加访问控制
>4. 类常量的值必须是一个==定值==;不能是类属性，不能是变量，不能是数学运算或函数调用结果
>
>```php
>const myConstant='abcd';
>const myConstant=['a','b','c'];
>const myConstant=<<<'label'//php>=5.3.0
>    abcd
>    label;
>```
>
>

###### (II)、调用方式

>```php
>echo self::myConstant;
>echo className::myConstant;
>```

##### c、方法

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

##### a、抽象类

##### b、匿名类

##### c、final类

### 2、interface

### 3、trait

### 4、对象继承问题

## (六)、特殊语法

### 1、引用

# 三、预定义

(一)、预定义数据载体

(二)、预定义异常



# 四、常用功能扩展

>其实所谓的功能扩展部分，完全是==函数的调用==了。没有新的语法规则了。

## (一)、cookie与seesion

## (二)、文件上传

### 1、post上传

## (三)、数学精度计算

## (四)、http请求

## (五)、邮件发送

## 国际时间换算

## 认证

http认证  文档>特点>用PHP进行http认证

Oauth 文档>函数参考>web服务>OAuth

## 反射reflection

## 生成验证图

## 操作mysql

链接pdo，增删改查



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

# 大小写问题

| 功能         | 区分大小写 | 举例                                            |
| ------------ | ---------- | ----------------------------------------------- |
| 变量         | 严格区分   | `$var`和`$vaR`是两个变量                        |
| 常量         | 严格区分   | `define('aBc',1)`和`define('abc', 1)`时两个常量 |
| 魔术常量     | 不区分     | `___CLASS__`和`__class__`相同                   |
| array中的key | 严格区分   | `['a'=>1, 'A'=>2]`数组中由两个不同元素          |
| 函数名       | 不区分     | `function aa`和`function Aa`相同                |
| 类属性       |            |                                                 |
| 类常量       |            |                                                 |
| 类方法       |            |                                                 |
| 类名         |            |                                                 |
| 命名空间     |            |                                                 |

# `==`与`===`问题

| 涉及场景        | 什么等 | 举例 | 备注 |
| --------------- | ------ | ---- | ---- |
| 判断运算符`<=>` | `==`   |      |      |
| switch..case    |        |      |      |
| in_array()      |        |      |      |

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

## call_user_func/call_user_func_array()



如何调用的：

>
>
>```php
>function myfun(){}
>
>class MyClass{
>	public function pubMethod(){}
>    public static function pubStaticMethod(){}
>}
>```
>
>



## 理解一下$GLOBALS



```php
//问题：$var是什么类型
$var=function(){return 5;};
var_dump(gettype($var));//object
var_dump($var instanceof Closure);//true
//说明$var是callback类型
echo $var+1;//6
```

## 理解continue和breake

>
>
>```php
>//如何正确理解continue和breake
>
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
>    echo "c".PHP_EOL;
>    continue;
>	echo 'd'.PHP_EOL;
>	break;
>}
>
>
>
>
>
>
>```
>
>