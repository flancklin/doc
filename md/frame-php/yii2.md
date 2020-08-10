# 一、入门须知

## (一)、环境需求

## (二)、安装

## (三)、文档结构

>
>
>yii2-app-advanced
>
>|
>
>|+ backend
>
>|+ frontend
>
>|			|+ assets
>
>|			|		|- AppAsset.php
>
>|			|+ config
>
>|			|		|- .gitignore
>
>|			|		|- bootstrap.php
>
>|			|		|- main.php
>
>|			|		|- params.php
>
>|			|		|- test.php
>
>|			|+ controllers
>
>|			|		|- SiteController.php
>
>|			|+ models
>
>|			|		|- .gitkeep
>
>|			|+ runtime
>
>|			|		|- .gitignore
>
>|			|+ tests
>
>|			|+ views
>
>|			|		|+ layouts
>
>|			|		|		|- main.php
>
>|			|		|- site
>
>|			|		|		|- error.php
>
>|			|		|		|- index.php
>
>|			|		|		|- login.php
>
>|			|+ web
>
>|			|		|+ assets
>
>|			|		|+ css
>
>|			|		|- favicon.ico
>
>|			|- codeception.yml
>
>|			|- Dokerfile
>
>|+ common
>
>|			|+ config
>
>|			|		|- .gitignore
>
>|			|		|- bootstrap.php
>
>|			|		|- main.php
>
>|			|		|- params.php
>
>|			|		|- test.php
>
>|			|+ fixtures
>
>|			|		|- UserFixture.php
>
>|			|+ mail
>
>|			|		|+ layouts
>
>|			|		|		|- html.php
>
>|			|		|		|- text.php
>
>|			|		|- emailVerify-html.php
>
>|			|		|- emailVerify-text.php 
>
>|			|		|- passwordResetToken-html.php
>
>|			|		|- passwordResetToken-text.php
>
>|			|+ models
>
>|			|		|- LoginForm.php
>
>|			|		|- User.php
>
>|			|+ tests
>
>|			|+ widgets
>
>|			|- codeception.yml
>
>|+ console
>
>|			|+ config
>
>|			|+ controllers
>
>|			|+ migrations
>
>|			|+ models
>
>|			|+ runtime
>
>|+ environments
>
>|			|+ dev
>
>|			|+ prod
>
>|			|- index.php
>
>|+ vagrant
>
>|			|+ config
>
>|			|+ nginx
>
>|			|+ provision
>
>|- bowerrc 			
>
>|- .gitignore
>
>|- codeception.yml
>
>|- composer.json
>
>|- docker-compose.yml
>
>|- init
>
>|- init.bat
>
>|- LICENSE.md
>
>|- README.md
>
>|- requirements.php
>
>|- Vagrantfile
>
>|- yii.bat

## (四)、hello world

## (五)、文档文献

**官网**

* https://www.yiichina.com/doc/guide/2.0

## 二、核心

一根藤(Yii)上接了无数个瓜(组件)

## (一)、路由router

## (二)、请求request

## (三)、控制器controller

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