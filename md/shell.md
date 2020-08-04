# 一、入门须知

## (一)、文件命名

比如my.sh 以.sh结尾

## (二)、文件格式

以输出hello world为例

>```shell
>#!/bin/bash
>echo "hello world"
>
>```

## (三)、注释方式

### 1、单行注释

> * `#`
>
>   ```shell
>   #!/bin/bash
>   #我是注释
>   ```
>
>   

### 2、多行注释

## (四)、行结束标志

每行用什么标志表示该行结束

## (五)、文档文献

## (六)、文件参数

>指令行输入如下：
>
>```shell
>#  sh test.sh 1 2 3
>```
>
>test.sh内部该如何接收参数？
>
>* 在test.sh中，
>* * \$0代表执行文件按名:test.sh；
>* * \$1代表1；\$2代表2；\$3代表3。

如何要求在文档运行中途必须传入参数？

>```shell
>#!/bin/bash
>echo 'please enter your name:'
>read yourName
>```
>
>运行sh ./test.sh 
>
>提示：please enter your name:
>
>输入....回车。输入的内容被变量`yourName`接收
>
>文件继续往下走....

# 二、语法

## (一)、数据类型

### 1、类型列表

| 序号 | 类型  | 举例          | 备注                       |
| ---- | ----- | ------------- | -------------------------- |
|      | array | (1 2 'a' 'b') | 调用`${array_name[index]}` |



### 2、细说数据类型

### 3、类型强转化

## (二)、运算符

### 运算符优先级

### 1、算数运算符

加减乘除求模求幂

### 2、比较运算符

### 3、逻辑运算符

## (三)、流程控制

### 1、循环

for / while等

### 2、判断

if等

### 3、引入文件

### 4、异常

### 5、其他



goto

## (四)、变量(区分大小写)

### 命名规则

### 声明定义、赋值(初始化)、调用

正确举例

>```shell
>var='hello world'
>var='hello china'
>var2=$var
>echo $var2#输出hello china
>```

错误举例

>```shell
>var = 'hello world'#错误 等号两边不能有空格
>$var='hello world'#错误，声明定义和赋值变量时都不用$,只有调用才需要$
>```

未知

>
>
>```shell
>echo var3
>echo $var4
>```
>
>

## (五)、function

1、命名规则

2、声明定义和初始化







## (六)、对象

## (七)、进程性指令

## (八)、其他语法

## 错误处理errors

# 三、预定义

(一)、预定义数据载体

(二)、预定义异常

# 四、常用功能扩展

更新git-yii

>
>
>```shell
>#!/bin/bash
>PROJECT='Collection'
>CONID='fengjinliang' 
>CONKEY='aaaaa' 
>GITBRANCH = 'dev'
>
> 
>echo "please enter your project:"
>read projectName2
>
>cd /root/project/weshare/dev/Collection
>git checkout ${GITBRANCH}
>expect -c "spawn git pull origin ${GITBRANCH}; expect \"*Username*\" { send \"${CONID}\n\"; exp_continue } \"*Password*\" { send \"${CONKEY}\n\" }; interact"
>expect -c "spawn php yii migrate; expect \"*Apply the above migration*\" { send \"yes\r\"; }; interact"
>```
>
>



