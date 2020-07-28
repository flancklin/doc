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

| 序号 | 类型     | 举例                     | 备注                                                         |
| ---- | -------- | ------------------------ | ------------------------------------------------------------ |
| 1    | boolean  | true\|false\|TRUE\|FALSE | 不区分大小写                                                 |
| 2    | integer  | -1\|0\|1                 | 支持2/8/10/16进制                                            |
| 3    | float    | -1.0\|0.0\|1.0           |                                                              |
| 4    | string   | '123'\|'abcd'            | [string](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html) 最大可以达到 2GB。<br>==可以当作array进行字符修改与获取== |
| 5    | null     | null\|NULL               | 仅定义默认为null；<br>变量被unset()<br>==都会有警告提示 PHP Notice== |
| 6    | array    | array(1,'1')\|[1,'1']    | new 类名                                                     |
| 7    | object   | new StdClass()           |                                                              |
| 8    | callback | function(){}             |                                                              |
| 9    | resource | file_open('filename')    |                                                              |

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

字符串==可以当作array==进行修改和读取单个字符

>```php
>//(汉字在utf-8中占三位，这样读取会乱码)
>echo $var4[0];//结果为a;
>$var4[0]=1;
>echo $var4;//结果为1bc
>```

字符串的四种定义方法：

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

定义方式有两种

>```php
>$var = array(1,'a');
>$var = [1, 'a'];
>```

关联数组与非关联数组

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

把object强转化为array

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







#### (1)、类型强转换



| 序号 | 类型     | 强转换                     | 备注                                                         |
| ---- | -------- | -------------------------- | ------------------------------------------------------------ |
| 1    | boolean  | (bool)\|(boolean)          | 当转换为 [boolean](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html) 时，以下值被认为是 **`FALSE`**：   <br>[布尔](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html)值 **`FALSE`** 本身<br/>[整型](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html)值 0（零）<br/>[浮点型](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)值 0.0（零）<br/>空[字符串](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html)，以及[字符串](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html) "0"  <br/>不包括任何元素的[数组](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.array.html)<br/>特殊类型 [NULL](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.null.html)（包括尚未赋值的变量）<br/>从空标记生成的 [SimpleXML](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/ref.simplexml.html) 对象<br>所有其它值都被认为是 **`TRUE`**（==包括任何[资源](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 和  **`NAN`**==）。 |
| 2    | integer  | (int)\|(integer)\|intval() | 从boolen转换：false-0,true-1<br>从float转换：向下取整<br>NaN和Infinity转换：0     （==php7.0.0==）<br>从string转换：以数字(含科学计数)开头则数字，其他为0<br>==没有定义从其它类型转换为整型的行为。*不要*依赖任何现有的行为，因为它会未加通知地改变== |
| 3    | float    |                            |                                                              |
| 4    | string   | (string)\|strval()         | 从boolean值转换：false-0,true-1<br>从integer和float转换：对应字符串<br>从array转换：‘Array’字样<br>从object转换：‘Object’字样<br>从resource转换：‘Resource id #1'字样<br>从null转换：空字符串 |
| 5    | null     |                            |                                                              |
| 6    | array    | (array)\|array($var)       | 对于任意 [integer](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.integer.html)，[float](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.float.html)，[string](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.string.html)，[boolean](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.boolean.html)    和 [resource](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.resource.html) 类型转为array，将得到一个只有一个元素的数组<br>将 **`NULL`** 转换为 [array](mk:@MSITStore:C:\Users\EDZ\Desktop\php74_zh(2020).chm::/res/language.types.array.html) 会得到一个空的数组<br>降object转为array：属性名为key，属性值为value |
| 7    | object   |                            |                                                              |
| 8    | callback |                            |                                                              |
| 9    | resource |                            |                                                              |



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

承载数据的东西。比如变量、常量等

#### (1)、变量

声明(定义) 赋值   使用

#### (2)、常量

#### 

## (二)、流程控制

### 1、循环

for / while等

### 2、判断

if等

### 3、异常

### 4、跳转

goto

# 三、对象

对象是特殊的数据类型。

# 四、预定义

(一)、预定义数据载体

(二)、预定义异常



# 五、特殊语法

## (一)、引用