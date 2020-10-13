# mysql

## cli

| 序号 | cli                     | 功能     | 注释         |
| ---- | ----------------------- | -------- | ------------ |
|      | `mysql -u root -p` 回车 | 登录     | 没有分号结尾 |
|      | `quit;`回车             | 退出cli  |              |
|      | `select version();`回车 | 版本信息 |              |
|      |                         |          |              |

>
>
>查看状态：show status like '%下面变量%';
>
>Aborted_clients 由于客户没有正确关闭连接已经死掉，已经放弃的连接数量。
>Aborted_connects 尝试已经失败的MySQL服务器的连接的次数。
>Connections 试图连接MySQL服务器的次数。
>Created_tmp_tables 当执行语句时，已经被创造了的隐含临时表的数量。
>Delayed_insert_threads 正在使用的延迟插入处理器线程的数量。
>Delayed_writes 用INSERT DELAYED写入的行数。
>Delayed_errors 用INSERT DELAYED写入的发生某些错误(可能重复键值)的行数。
>Flush_commands 执行FLUSH命令的次数。
>Handler_delete 请求从一张表中删除行的次数。
>Handler_read_first 请求读入表中第一行的次数。
>Handler_read_key 请求数字基于键读行。
>Handler_read_next 请求读入基于一个键的一行的次数。
>Handler_read_rnd 请求读入基于一个固定位置的一行的次数。
>Handler_update 请求更新表中一行的次数。
>Handler_write 请求向表中插入一行的次数。
>Key_blocks_used 用于关键字缓存的块的数量。
>Key_read_requests 请求从缓存读入一个键值的次数。
>Key_reads 从磁盘物理读入一个键值的次数。
>Key_write_requests 请求将一个关键字块写入缓存次数。
>Key_writes 将一个键值块物理写入磁盘的次数。
>Max_used_connections 同时使用的连接的最大数目。
>Not_flushed_key_blocks 在键缓存中已经改变但是还没被清空到磁盘上的键块。
>Not_flushed_delayed_rows 在INSERT DELAY队列中等待写入的行的数量。
>Open_tables 打开表的数量。
>Open_files 打开文件的数量。
>Open_streams 打开流的数量(主要用于日志记载）
>Opened_tables 已经打开的表的数量。
>Questions 发往服务器的查询的数量。
>Slow_queries 要花超过long_query_time时间的查询数量。
>Threads_connected 当前打开的连接的数量。
>Threads_running 不在睡眠的线程数量。
>Uptime 服务器工作了多少秒。

## 数据引擎(表)

>| 特点     | MyISAM       | InnoDB             | MEMORY   | MERGE | NDB  |
>| -------- | ------------ | ------------------ | -------- | ----- | ---- |
>| 数据结构 | B+树         | B+树               | hash     |       |      |
>| 事务     |              | 支持               |          |       |      |
>| 锁       | 表锁         | 表+行锁            | 表锁     | 表锁  | 表锁 |
>| 外键     |              | 支持               |          |       |      |
>| 索引     | B树+fulltext | B树+fulltext(5.6+) | B树+hash |       | hash |



## Query

## 索引

| 序号 | 索引类型         | 约束                  | x    |
| ---- | ---------------- | --------------------- | ---- |
|      | 主键索引         | 依据表主键            |      |
|      | 唯一索引unique   | 值唯一(可null)        |      |
|      | 全文索引fulltext | 限字符类型char/text等 |      |
|      | 普通索引normal   |                       |      |
|      | 组合索引         |                       |      |



### 聚簇索引

索引树上有数据集

比如：表中主键的索引

纪录的索引顺序与物理顺序相同。因此更适合between and和order by操作

### 非聚簇索引

索引树上没有数据集

索引过多会影响insert和update的速度

## 锁

学习文章：https://blog.csdn.net/Saintyyu/article/details/91269087

​					https://www.cnblogs.com/chenqionghe/p/4845693.html

| 序号 | 锁                                                           | a    | a    |
| ---- | ------------------------------------------------------------ | ---- | ---- |
|      | 行锁（Record Locks）                                         |      |      |
|      | 间隙锁（Gap Locks）                                          |      |      |
|      | 临键锁（Next-key Locks）                                     |      |      |
|      | 共享锁/排他锁（Shared and Exclusive Locks）                  |      |      |
|      | 意向共享锁/意向排他锁（Intention Shared and Exclusive Locks） |      |      |
|      | 插入意向锁（Insert Intention Locks）                         |      |      |
|      | 自增锁（Auto-inc Locks）                                     |      |      |



| 引擎   | 分类   | 锁             | 功能 | 注释                       |
| ------ | ------ | -------------- | ---- | -------------------------- |
| InnoDB | 行级锁 | 共享锁(S)      | 读锁 | 允许事务读一行数据         |
|        |        | 排他锁(X)      | 写锁 | 允许事务删除或更新一行数据 |
|        | 表级锁 | 意向共享锁(IS) |      |                            |
|        |        | 意向排他锁(IX) |      |                            |

==意向锁是InnoDB自动加的，不需用户干预==

当前锁模式/是否兼容/请求锁模式

|      | X    | IX   | S    | IS   |
| ---- | ---- | ---- | ---- | ---- |
| X    | 冲突 | -    | -    | -    |
| IX   | -    | 兼容 | -    | 兼容 |
| S    | 冲突 | -    | 兼容 | 兼容 |
| IS   | -    | 兼容 | 兼容 | 兼容 |

### **获取InonoD行锁争用情况**

可以通过检查InnoDB_row_lock状态变量来分析系统上的行锁的争夺情况：

> ```sql
> mysql> show status like 'innodb_row_lock%';
> +-------------------------------+-------+
> | Variable_name | Value |
> +-------------------------------+-------+
> | Innodb_row_lock_current_waits | 0 |
> | Innodb_row_lock_time | 0 |
> | Innodb_row_lock_time_avg | 0 |
> | Innodb_row_lock_time_max | 0 |
> | Innodb_row_lock_waits | 0 |
> +-------------------------------+-------+
> 5 rows in set (0.00 sec)
> ```

如果发现争用比较严重，如Innodb_row_lock_waits和Innodb_row_lock_time_avg的值比较高，还可以通过设置InnoDB Monitors来进一步观察发生锁冲突的表、数据行等，并分析锁争用的原因。

### 杂碎



>查看lock设置的过期时间
>
>SHOW VARIABLES LIKE 'innodb_lock_wait_timeout'
>
>SET innodb_lock_wait_timeout=5
>
>
>
>查看是否有锁表
>
>mysql> show open tables where in_use>0;
>
>
>
>**-- 查询是否锁表**
>
>show OPEN TABLES ;
>
>**-- 查询进程**
>
>show processlist ;
>
>**-- 查询到相对应的进程，然后杀死进程**
>
>kill id; -- 一般到这一步就解锁了
>
>**-- 查看正在锁的事务**
>
>SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCKS;
>
>**-- 查看等待锁的事务**
>
>SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCK_WAITS;
>
>**-- 解锁表**
>
>UNLOCK TABLES;

> 
>
> **方案一：**
>
>1、查看是否有锁表
>
>```
>show OPEN TABLES where In_use > 0;
>```
>
>2、查询进程（如果你有SUPER权限，你可以看到所有线程。否则，只能看到你自己的线程）
>
>```
>show processlist;
>```
>
>3、杀死进程id（就是上面命令的id列）
>
>```
>kill id
>```
>
> 
>
>**方案二：**
>
>1、查看在锁的事务
>
>```
>SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX;
>```
>
>2、杀死进程id（就是上面命令的trx_mysql_thread_id列）
>
>```
>kill id
>```
>
>  
>
> 
>
>

>```
># 查看当前的事务
>SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX;
>
># 查看当前锁定的事务
>SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCKS;
>
># 查看当前等锁的事务
>SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCK_WAITS; 
>```

## 事务

### 事务隔离级别

如果没有采取必要的隔离机制，就会导致各种并发问题:

>
>
>➢**脏读:**对于两个事务T1,T2,T1读取了已经被T2更新但还没有被提交的字段.之后，若T2回滚，T1读取的内容就是临时且无效的.
>
>
>➢**不可重复读:**对于两个事务T1, T2, T1读取了一个字段,然后T2更新了该字段之后，T1再次读取同一个字段,值就不同了，
>
>
>
>➢**幻读:**对于两个事务T1,T2,T1从一个表中读取了一个字段,然后T2在该表中插入了一些新的行.之后，如果T1再次读取同一个表,就会多出几行

| 序号 | 级别                  | 功能         | 脏读 | 不可重复读 | 幻读 |
| ---- | --------------------- | ------------ | ---- | ---------- | ---- |
| 1    | READ UNCOMMITTED      | 读未提交数据 |      |            |      |
| 2    | READ COMMITED         | 读已提交数据 | 解决 |            |      |
| 3    | REPEATABLE READ(默认) | 可重复读     | 解决 | 解决       |      |
| 4    | SERIALIZABLE          | 可串行化     | 解决 | 解决       | 解决 |



## 存储过程/函数

### 1、官方定义

> ```sql
> CREATE
>     [DEFINER = user]
>     PROCEDURE sp_name ([proc_parameter[,...]])
>     [characteristic ...] routine_body
> 
> CREATE
>     [DEFINER = user]
>     FUNCTION sp_name ([func_parameter[,...]])
>     RETURNS type
>     [characteristic ...] routine_body
>     
> #**********************************************************************************************#
> 
> proc_parameter:
>     [ IN | OUT | INOUT ] param_name type
> 
> func_parameter:
>     param_name type
> 
> type:
>     Any valid MySQL data type
> 
> characteristic: {
>     COMMENT 'string'
>   | LANGUAGE SQL
>   | [NOT] DETERMINISTIC
>   | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
>   | SQL SECURITY { DEFINER | INVOKER }
> }
> 
> routine_body:
>     Valid SQL routine statement
> ```
>
> 

### 2、参数

> ```sql
> delimiter //
> 
> CREATE PROCEDURE citycount (IN country CHAR(3), OUT cities INT)
> BEGIN
>   SELECT COUNT(*) INTO cities FROM world.city
>   WHERE CountryCode = country;
> END//
> 
> delimiter ;
> 
> #调用
>  CALL citycount('JPN', @cities);
>  SELECT @cities;
> ```
>
> 

### 3、定义变量

> ```sql
> declare v0 int 0;
> declare v1 int 1;
> declare v2 int 2;
> declare v3 varchar(10) default "";
> ```

### 4、变量运算

> ```sql
> set v0 = v1 + v2;            #等号和+号可以用空格优化格式
> ```
>
> 

### 5、逻辑判断

| 功能     | 符号 | 示例 | 备注 |
| -------- | ---- | ---- | ---- |
| 等于     |      |      |      |
| 不等于   |      |      |      |
| 大于     |      |      |      |
| 大于等于 |      |      |      |
| 小于     |      |      |      |
| 小于等于 |      |      |      |
|          |      |      |      |
| 且       |      |      |      |
| 或       |      |      |      |



### 6、判断

#### (1)、if(条件，exp1，exp2)

`条件?exp1:exp2`

这个有点像==三目运算==

可以在==平时sql中==也可以在==存储过程中==



##### 存储过程：

> ```sql
> delimiter $$
> create PROCEDURE aa2()
> BEGIN
> 		DECLARE v1 int DEFAULT 1;
> 		DECLARE v2 int DEFAULT 2;
> 		
> 		DECLARE v0 int DEFAULT 0;
> 		DECLARE v00 int DEFAULT 0;
> 		
> 		set v0 = if(v1=1,11,99);
> 		set v00 = if(v2>1,22,99);
> 		SELECT v0,v00;
> END$$
> delimiter ;
> 
> CALL aa2()
> 
> 
> #v0输出11，v00输出22
> CALL aa()
> ```



##### 平时sql:

> ```sql
> SELECT id,if(timezone>0,'大于0', timezone) from shop_facebook_40 
> 
> #输出结果集
> id  timezone
> 1	大于0
> 2	-7
> ```

#### (2)、ifnull(exp1,exp2)

`exp1 is null ? exp2 : exp1`

如果exp1为空，则输出exp2

> ```sql
> select ifnull(null,'a')#输出a
> select ifnull(1+9,'a') #输出10
> ```

#### (3)、if...（elseif）

可以由“=、<、<=、>、>=、!=”等条件运算符组成，

并且可以使用AND、OR、NOT对多个表达式进行组合

> ```sql
> IF search_condition THEN 
>     statement_list  
> [ELSEIF search_condition THEN]  
>     statement_list ...  
> [ELSE 
>     statement_list]  
> END IF;#这里需要一个结束符号，标识if语句结束 
> ```

#### (4)、case...end

##### 字段挨着case

> ```sql
> SELECT
> CASE
> 	timezone 
> 	WHEN 8 THEN '东8' 
> 	WHEN -7 THEN '负7' 
> 	ELSE '其他时区' 
> END AS aa 
> FROM
> shop_facebook_40
> ```

##### 字段挨着when

> ```sql
> 
> update shop_facebook_40
> set timezone = (
> 	case 
> 		when timezone between 1 and 12 then  1
> 		when timezone between -12 and -1 then  -1
> 		else  0
> 	end
> );
> ```

### 7、循环

#### while...do

> ```sql
> WHILE expression DO  
>    Statements  
> END WHILE;  
> ```
>
> 



#### repeat

> ```sql
> REPEAT  
> 	Statements;  
> UNTIL expression END REPEAT;
> ```
>
> 

#### loop

> ```sql
> loop
> 	Statements;  #leave-break;iterate-continue
> end loop;
> ```
>
> 



#### 游标遍历

> ```sql
> 
> declare v_f1 int default 0;#定义两个变量接收游标读取的数据
> declare v_f2 int default 0;
> 
> declare v_cursor CURSOR FOR select f1,f2 from tabel_name;#定义游标
> open v_cursor;#开启游标
> 循环开始标志
> 	fetch v_cursor into v_f1,v_f2;//从游标中获取对应变量
> 	#业务处理
> 循环结束标志
> 
> close v_cursor;#关闭游标
> ```
>
> 



### 8、异常处理

==declare……handler语句必须出现在变量或条件声明的后面。==

> ```sql
> DECLARE handler_action HANDLER
>     FOR condition_value [, condition_value] ...
>     statement
> 
> handler_action:
>     CONTINUE       #继续执行当前的程序(接着执行出错的SQL的下一条语句)；
>     | EXIT         #当前程序终止(退出当前declare所在的begin end)； 
> 
> condition_value:
>     mysql_error_code
>     | SQLSTATE [VALUE] sqlstate_value
>     | condition_name
>     | SQLWARNING
>     | NOT FOUND
>     | SQLEXCEPTION
> ```
>
>  
>
> > ```sql
> > DECLARE CONTINUE HANDLER FOR 1329 SET v_flag=1;
> > ```



### 示例

#### (1)、代替union

原sql:

> ```sql
> (SELECT shop,COUNT(id) from shop_22 where shop='shop' and  created_at BETWEEN '2020-10-12 11:10:00' AND '2020-10-12 15:00:00')
> UNION
> (SELECT shop,COUNT(id) from shop_33 where shop='shop' and  created_at BETWEEN  '2020-10-12 11:10:00' AND '2020-10-12 15:00:00')
> UNION
> (SELECT shop,COUNT(id) from shop_36 where shop='shop' and  created_at BETWEEN  '2020-10-12 11:10:00' AND '2020-10-12 15:00:00')
> UNION
> (SELECT shop,COUNT(id) from shop_40 where shop='shop' and  created_at BETWEEN  '2020-10-12 11:10:00' AND '2020-10-12 15:00:00')
> UNION
> (SELECT shop,COUNT(id) from shop_44 where shop='shop' and  created_at BETWEEN  '2020-10-12 11:10:00' AND '2020-10-12 15:00:00')
> ```

用存储过程

> ```sql
> delimiter $$ # 声明存储过程的结束符号为$$
> CREATE DEFINER=`root`@`localhost` PROCEDURE `k`(IN shop VARCHAR(100),IN begin_at VARCHAR(100),IN end_at VARCHAR(100))
> BEGIN
> 
> DECLARE v_table_name VARCHAR(50) DEFAULT "";
> DECLARE v_sql LONGTEXT DEFAULT "";
> DECLARE v_sub_sql LONGTEXT DEFAULT "";
> DECLARE v_count INT DEFAULT 0;
> 
> #如果11行和12行调换上下位置，会报错
> DECLARE v_all_tables CURSOR for (SELECT TABLE_NAME from information_schema.`TABLES` where TABLE_NAME REGEXP "shop_[0-99999]" and TABLE_SCHEMA="local_exit");
> set v_count=(SELECT COUNT(DISTINCT TABLE_NAME) from information_schema.`TABLES` where TABLE_NAME REGEXP "shop_[0-99999]" and TABLE_SCHEMA="local_exit");
> 
> OPEN v_all_tables;
> 
> WHILE v_count>0 DO
> 	 FETCH v_all_tables INTO v_table_name;	
>  
> 	 set v_sub_sql=concat('(SELECT shop,COUNT(id) as num from ',v_table_name, ' where ',if(shop='','',CONCAT(' `shop`="', shop,'" and ')),' created_at BETWEEN  "',begin_at,'" AND "',end_at,'")');
> 	 
> 	 if v_sql='' then
> 			set v_sql=v_sub_sql;
> 	 else
> 			set v_sql=CONCAT(v_sql," union ", v_sub_sql);
> 	 end if;
> 	 
> 	 set v_count=v_count-1;
> END WHILE;
> CLOSE v_all_tables;#记得关闭游标
> 
> set @varsql=v_sql;#文档上没有强制全局变量，但是不用全局变量，下一行会报错
> PREPARE tmpsql FROM @varsql;
> EXECUTE tmpsql;
> DEALLOCATE PREPARE tmpsql;
> 
> SELECT v_sql;
> 
> END$$
> delimiter ; # 声明存储过程的结束符号为$$
> ```



#### (2)、产生随机记录

> ```sql
> delimiter $$ # 声明存储过程的结束符号为$$
> create procedure randData5(IN num INT)
> BEGIN
> 		#声明必须放在最前面
>  declare i int default 1;
> 		declare a int DEFAULT 0;
> 		declare b int DEFAULT 0;
> 		declare c VARCHAR(20) DEFAULT '';
> 		declare d VARCHAR(20) DEFAULT '';
> 		#创建测试表
> 		DROP TABLE IF EXISTS `tp_tt`;
> 		CREATE TABLE `tp_tt`  (
> 			`id` int(11) NOT NULL,
> 			`a` int(10) NULL DEFAULT NULL,
> 			`b` int(10) NULL DEFAULT NULL,
> 			`c` varchar(20) NULL DEFAULT NULL,
> 			`d` varchar(20) NULL DEFAULT NULL,
> 			PRIMARY KEY (`id`) USING BTREE
> 		) ENGINE = InnoDB;
> 		#往测试表中塞入数据
> 		if num<100 THEN
> 				set num=100;
> 		ELSE
> 				set num=num;#只是为了写完整的if...else..
> 		END IF;
> 	
>  while(i<num)do
> 				set a=FLOOR(100+(RAND()*1900));#随机数字 RAND()取值0-1的小数
> 				set b=FLOOR(100+(RAND()*1900));
> 				set c=substring(MD5(RAND()),1,20);#随机字符串-用随机数字演变的
> 				set d=substring(MD5(RAND()),1,20);
> 				
>      insert into tp_tt (`id`,`a`,`b`,`c`,`d`) values(i,a,b,c,d);
>      set i=i+1;
>  end while;
> END$$ # $$结束
> delimiter ; # 重新声明分号为结束符号
> ```



## 主从分离

![mysql主从分离逻辑](static/db/mysql%E4%B8%BB%E4%BB%8E%E5%88%86%E7%A6%BB%E9%80%BB%E8%BE%91.png)

> 配置文件：windows找mysql.ini；linux找my.cnf；

### 主机配置与测试

#### (1)、改配置

>在配置文件中，找到`[mysqld]`
>
>在其下面插入一下代码
>
>```shell
>[mysqld]
>#红色的为新配置的打开binary log的配置
>#配置binary log
>#配置server-id
>server-id=1
>#打开二进制日志文件
>log-bin=master-bin
>#打开二进制日志文件索引
>log-bin-index=master-bin.index
>```

#### (2)、重启mysqld

#### (3)、验证

>进入mysql指令界面
>
>```shell
>mysql> show master status;
>+-------------------+----------+--------------+------------------+-------------------+
>| File              | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
>+-------------------+----------+--------------+------------------+-------------------+
>| master-bin.000002 |      154 |              |                  |                   |
>+-------------------+----------+--------------+------------------+-------------------+
>
>```
>
>

### 从机配置与测试

#### (1)、改配置

> 在配置文件中，找到`[mysqld]`
>
> 在其下面插入一下代码
>
> ```shell
>   #配置relay log
>   #配置server id
>   server-id=2
>   #打开从服务器中介日志文件
>   relay-log=slave-relay-bin
>   #打开从服务器中介日志文件索引
>   relay-log-index=slave-relay-bin.index
> ```
>
> 

#### (2)、重启mysqld

#### (3)、连接主机

> ```shell
> mysql> change master to master_host='主服务器IP',master_port=主服务器MYSQL端口,master_user='用户名',master_password='密码',master_log_file='master-bin.000001',master_log_pos=0;
> 
> ```

#### (4)、开始主从同步

>```shell
>mysql> start slave;
>```
>
>停止是：stop slave;

#### (5)、验证

> ```shell
> mysql> show slave status;
> ```
>
> ![mysql主从分离-slave](static/db/mysql%E4%B8%BB%E4%BB%8E%E5%88%86%E7%A6%BB-slave.jpg)

### 测试

>在主服务器创建一个数据库：create database ttt;
>
>在从服务器中查看：show databases;

## 备份？

# redis-server/cli

> ```php
> //centos下看是否安装redis及其版本号
> # redis-server -v
> 
> Redis server v=6.0.6 sha=00000000:0 malloc=jemalloc-5.1.0 bits=64 build=3f4720fbc51b9c9
> //版本为5.1.0
> ```
>

## 概述

### 1、官方文档

官网：https://redis.io/

官方推荐文档：https://github.com/redis/redis-doc

指令文档：https://github.com/redis/redis-doc/blob/master/commands.json

指令文档：https://redis.io/commands/+指令

| 场景        | 调用                       | 路径                                          | 备注                                          |
| ----------- | -------------------------- | --------------------------------------------- | --------------------------------------------- |
| php原生支持 | new \Redis()               | php.jar > stubs > redis > Redis.php           | 需要php_redis.dll文件，配置php.ini的extension |
| yii2支持    | new yii\redis\Connection() | app/vendor/yiisoft/yii2-redis/src/Connect.php | 不用安装redis扩展                             |

### 2、查看版本号

| 序号 | 位置              | 指令            | 备注 |
| ---- | ----------------- | --------------- | ---- |
| 1    | 在redis内部       | info+回车       |      |
| 2    | 在linux或者window | redis-server -v |      |

### 3、进入redis

> ```shell
> #redis-cli -h 127.0.0.1 -p 6379 -a myPassword
> ```

### 4、null与nil

redis种null的写法是nil

### 5、解析command

> ```php
> <?php
> $redisArr = include_once './redis-command.php';
> $data = [];
> $maxVersion = 0;
> foreach ($redisArr as $command => $remark){
>     $group = $remark['group'];
>     $version = explode('.', $remark['since']);
>     $remark['version'] = $version[0];
>     $maxVersion < $version[0] && $maxVersion = $version[0];
>     if(!isset($data[$group])) $data[$group] = [];
>     $data[$group][$command] = $remark;
> }
> echo "version:".$maxVersion.'<br>';
> $i = 1;
> foreach ($data as $group => $commands){
>     echo $i++ . '-'.$group  . '<br>';
>     showCommand($commands);
> }
> 
> function showCommand($commands, $version = 0){
>     $j = 1;
>     foreach ($commands as $command => $remark){
> //        if($command == 'SET') var_dump($remark);
>         if($remark['version'] == $version){
>             $o = [];
>             if(isset($remark['complexity'])){
>                 $oA = explode(' ', $remark['complexity']);
>                 foreach ($oA as $oi){
>                     if(stripos($oi, 'O(') !== 0){
>                         continue;
>                     }else{
>                         $oi && $o[] = $oi;
>                     }
>                 }
>                 if($o){
>                     foreach ($o as &$oj){
>                         $oj = trim($oj,'., ');
>                         if(stripos($oj, 'O(') !== 0){
>                             $oj = '?-?';
>                         }elseif(substr_count($oj, '(') != substr_count($oj, ')')){
>                             $oj .= '?';
>                         }
>                     }
>                     $o = array_unique($o);
>                     $o = implode('/', $o);
>                 }
>             }
>             $o || $o = "无";
>             $c = strtolower($command);
>             $s = str_pad($j++,2,0,STR_PAD_LEFT).'='.$version.'='.$o.'='. $c.'=<a href="https://redis.io/commands/'.strtr($command,' ', '-').'">';
>             !isset($remark['arguments']) && $remark['arguments'] = [];
>             foreach ($remark['arguments'] as $param){
>                 if(isset($param['enum'])){
>                     $p =implode('|', $param['enum']);
>                 }elseif(is_array($param['name'])){
>                     $p = implode(' ', $param['name']);
>                 }else{
>                     $p = $param['name'];
>                 }
> 
>                 if(isset($param['multiple']) && $param['multiple']) $p .=" [{$p} ...]";
>                 if(isset($param['optional']) && $param['optional']){
>                     $c .= "  [" . $p .']';
>                 }else{
>                     $c .= "  " . $p;
>                 }
>             }
>             echo $s.="{$c}</a><br>";
>         }
>     }
>     $version < 10 && showCommand($commands, $version + 1);
> }
> ```
>
> 

## (一)、string

| 序号                                        | 复杂度                   | 版   | 功能  | 指令        | 指令参数                                                     |
| ------------------------------------------- | ------------------------ | ---- | ----- | ----------- | ------------------------------------------------------------ |
| [1](https://redis.io/commands/set)          | O(1)                     | 1    | 入    | set         | set key value [EX seconds\|PX milliseconds\|KEEPTTL] [NX\|XX] |
| [2](https://redis.io/commands/setnx)        | O(1)                     | 1    | 入    | setnx       | setnx key value                                              |
| [3](https://redis.io/commands/msetnx)       | O(N)                     | 1    | 入    | msetnx      | msetnx key value [key value ...]                             |
| [4](https://redis.io/commands/append)       | O(1)                     | 2    | 入    | append      | append key value                                             |
| [5](https://redis.io/commands/psetex)       | O(1)                     | 2    | 入    | psetex      | psetex key milliseconds value                                |
| [6](https://redis.io/commands/setbit)       | O(1)                     | 2    | 入    | setbit      | setbit key offset value                                      |
| [7](https://redis.io/commands/setex)        | O(1)                     | 2    | 入    | setex       | setex key seconds value                                      |
| [8](https://redis.io/commands/setrange)     | O(1)/O(M)                | 2    | 入    | setrange    | setrange key offset value                                    |
| [9](https://redis.io/commands/get)          | O(1)                     | 1    | 取    | get         | get key                                                      |
| [10](https://redis.io/commands/mget)        | O(N)                     | 1    | 取    | mget        | mget key [key ...]                                           |
| [11](https://redis.io/commands/mset)        | O(N)                     | 1    | 取    | mset        | mset key value [key value ...]                               |
| [12](https://redis.io/commands/getbit)      | O(1)                     | 2    | 取    | getbit      | getbit key offset                                            |
| [13](https://redis.io/commands/getrange)    | O(N)/O(1)                | 2    | 取    | getrange    | getrange key start end                                       |
| [14](https://redis.io/commands/getset)      | O(1)                     | 1    | 入+取 | getset      | getset key value                                             |
| [15](https://redis.io/commands/decr)        | O(1)                     | 1    | 减    | decr        | decr key                                                     |
| [16](https://redis.io/commands/decrby)      | O(1)                     | 1    | 减    | decrby      | decrby key decrement                                         |
| [17](https://redis.io/commands/incr)        | O(1)                     | 1    | 增    | incr        | incr key                                                     |
| [18](https://redis.io/commands/incrby)      | O(1)                     | 1    | 增    | incrby      | incrby key increment                                         |
| [19](https://redis.io/commands/incrbyfloat) | O(1)                     | 2    | 增    | incrbyfloat | incrbyfloat key increment                                    |
| [20](https://redis.io/commands/bitcount)    | O(N)                     | 2    |       | bitcount    | bitcount key [start end]                                     |
| [21](https://redis.io/commands/bitop)       | O(N)                     | 2    |       | bitop       | bitop operation destkey key [key ...]                        |
| [22](https://redis.io/commands/bitpos)      | O(N)                     | 2    |       | bitpos      | bitpos key bit [start] [end]                                 |
| [23](https://redis.io/commands/strlen)      | O(1)                     | 2    | 长    | strlen      | strlen key                                                   |
| [24](https://redis.io/commands/bitfield)    | O(1)                     | 3    |       | bitfield    | bitfield key [type offset] [type offset value] [type offset increment] [WRAP\|SAT\|FAIL] |
| [25](https://redis.io/commands/stralgo)     | O(strlen(s1)*strlen(s2)) | 6    |       | stralgo     | stralgo LCS algo-specific-argument [algo-specific-argument ...] |

> * getset既存也取。因为第一次getset的时候，库种没有值，故而返回null，但是存入是成功了的

| 参数                         | 功能                    | 备注       |
| ---------------------------- | ----------------------- | ---------- |
| EX senconds\|PX milliseconds | 过期时间(秒和毫秒)      | \>= 2.6.12 |
| NX\|XX                       | 不存在则存入/存在才存入 | \>= 2.6.12 |
| KEEPTTL                      |                         |            |

## (二)、hash

### 1、增/改

### 2、删

### 3、查

### 4、属性

## (三)、list

1、增/改

2、删

3、查

4、属性

## (四)、set

1、增/改

2、删

3、查

4、属性

## (五)、zset

1、增/改

2、删

3、查

4、属性

## (六)、script

### lua

> ```php
> public function actionTt1(){
>     $redis = \Yii::$app->redis;
>     $script = <<<LUA
> local flagKey=KEYS[1]
> local key1=KEYS[2]
> local value1=ARGV[1]
> if(redis.call("get",flagKey)) then
>     return redis.call("set",key1,value1)
> end
> LUA;
>     //$redis->set("aa",'aa');
>     $r = $redis->eval($script, 2,'aa','k', 'v');
>     var_dump($r);
> }
> ```
>
> 

## 其他

### (一)、安装

#### 1、linux安装

#### 2、windows安装

参考链接：  https://www.cnblogs.com/liuqingzheng/p/9831331.html

##### a、下载安装包

​       https://github.com/microsoftarchive/redis/releases   选择.msi

##### b、运行msi进行安装

##### c、设密码

>安装完毕后，需要先做一些设定工作，以便服务启动后能正常运行。使用文本编辑器，这里使用Notepad++，打开Redis服务配置文件。**注意：不要找错了，通常为redis.windows-service.conf，而不是redis.windows.conf。后者是以非系统服务方式启动程序使用的配置文件。**
>
>![img](https://images.cnblogs.com/cnblogs_com/jaign/1123087/o_9.png)
>
>10、找到含有requirepass字样的地方，追加一行，输入requirepass 12345。这是访问Redis时所需的密码，一般测试情况下可以不用设定密码。不过，即使是作为本地访问，也建议设定一个密码。此处以简单的12345来演示。



##### d、启动服务

>点击“开始”>右击“计算机”>选择“管理”。在左侧栏中依次找到并点击“计算机管理（本地）”>服务和应用程序>服务。再在右侧找到Redis名称的服务，查看启动情况。如未启动，则手动启动之。正常情况下，服务应该正常启动并运行了。

##### e、ok拉---修改php.ini

###### I、下载php_redis.dll

phpredis扩展下载地址  http://windows.php.net/downloads/pecl/snaps/redis/

###### II、把php_redis.dll放在php目录下

将下载好的php_redis.dll放入E:\wamp64\bin\php\php5.6.25\ext文件夹中

###### III、修改php.ini文件

E:\wamp64\bin\apache\apache2.4.23\bin\php.ini添加代码:

 			extension=php_redis.dll

## 问题

### 穿刺

#### 问题描述：

指的是**单个key**在缓存中查不到，去数据库查询，

> ```php
> $data = [];
> if(!$data=Redis::get($key)){
>     $data = (new Query)->where(...)->one();
>     if($data){
>         Redis::set($key, json_encode($data), 86400)
>     }else{
>         //....这里如果db中没有数据，没有存储，若key一直空，则会不断请求db
>     }
> }
> return $data ? json_decode($data) : [];
> ```

#### 解决问题：

根本思想：不论你db中是否真实有数据。我都把查询的结果集存储起来，哪怕试空也要存。

> ```php
> if(!$data= Redis::get($key)){
>     $data = (new Query)->where(...)->one();
>     $data = json_encode($data);
>     Redis::set($key, $data, 86400);
> }
> return json_decode($data);
> ```
>
> 



### 击穿

#### 问题描述：

当缓存【数据失效】到把数据【重新塞入redis】这个过程需要时间，这个时间范围没有缓存，所有的 请求会直扑db。造成db崩

#### 解决问题：

方案一：设置缓存永久有效(数据变动，主动更新即可)

方案二：设置互斥锁，当数据失效的时候，只有一个请求可以访问db，其他的就等着，等第一个请求并存入缓存，其他人直接拿缓存数据

### 雪崩

#### 问题描述

指的是**多个key**查询并且出现**高并发**，缓存中失效或者查不到，然后都去db查询，从而导致db压力突然飙升，从而崩溃。

（概率很小，因为各个key的失效时间能在同一时间，比较难。但不排除没有这种可能）

# memcached

一、string

二、

三、

四、

五、

其他

(一)、安装

1、linux安装

2、windows安装



# 数据结构

| 序号 | 数据结构        | 概念                                                         | 复杂度  | 优点                     | 缺点          |
| ---- | --------------- | ------------------------------------------------------------ | ------- | ------------------------ | ------------- |
| 1    | 二叉树          |                                                              |         |                          |               |
| 2    | 满二树          | 全满==(节点)==                                               |         |                          |               |
| 3    | 完全二叉树      | 左满==(节点)==                                               |         |                          |               |
| 4    | 堆              | 堆中某个节点的值总是不大于或不小于其父节点的值； <br>堆总是一棵完全二叉树 |         |                          |               |
| 5    | 排序二叉树(BST) | 左子树值<(根)节点==值==<右子树值                             | O(logN) |                          | 不平衡        |
| 6    | 平衡二叉树(AVL) | 左子树与左子树的==深度==差不超过1                            |         |                          | 插入/删除耗时 |
| 7    | 红黑数          | 最大深度== <= 最小==深度==的两倍                             |         | 删数快                   | 树太高        |
| 8    | B-tree(B树)     | ==多叉==；所有叶子节点在同一层                               | O(logN) | 局部性原理(空间和时间)   |               |
| 9    | B+tree(B+树)    | 数据都在叶子上。叶子间是双向链表                             | O(logN) | 支持范围查询；IO次数更少 |               |
| 10   | B\*tree(B\*树)  |                                                              |         |                          |               |

>**局部性原理**
>
>* 空间局部性原理：程序和数据的访问有聚集成群的倾向，在某时间段，仅使用其中一小部分
>* 时间局部性原理：或者最近访问的程序代码和数据，很快又被访问的可能性很大
>
>
>
>**二叉树遍历**
>
>依据根所在位置，在前、在中、在后分为：
>
>​			前序遍历（前根遍历）：**根**——>左——>右
>
>​			中序遍历（中根遍历）：左——>**根**——>右
>
>​			后序遍历（后根遍历）：左——>右——>**根**
>
>已知前序和中序，求后序问题， 前序 ABDGCEFH  中序 DGBAECHF
>
>解法：根据前序、中序综合判断画出树的节点图，然后再写后序遍历：DGBEHFCA
>
>![二叉树的遍历](static/db/%E4%BA%8C%E5%8F%89%E6%A0%91%E7%9A%84%E9%81%8D%E5%8E%86.png)

## 满二叉树

![满二叉树](static/db/%E6%BB%A1%E4%BA%8C%E5%8F%89%E6%A0%91.png)

## 完全二叉树

==左满==

若设二叉树的深度为h，

* 除第 h 层外，其它各层 (1～h-1) 的结点数都达到最大个数(即1~h-1层为一个满二叉树)，
* 第 h 层所有的结点都连续集中在最左边，这就是完全二叉树。

![完全二叉树](static/db/%E5%AE%8C%E5%85%A8%E4%BA%8C%E5%8F%89%E6%A0%91.png)

## 排序二叉树(BST)

排序二叉树又叫查找二叉树。

在二叉树的基础上满足：

* 任意节点的左边小于(根)节点，右边大于(根)节点

  ![排序二叉树](static/db/%E6%8E%92%E5%BA%8F%E4%BA%8C%E5%8F%89%E6%A0%91.jpg)

## 平衡二叉树(AVL) 

所有的节点的左子树和右子树的深度差不超1

## 红黑树

## B-Tree（B树）

B树又叫平衡多路查找树（平衡+多路+查找）





更多关于B树和B+树的理解：https://blog.csdn.net/qq_26222859/article/details/80631121

## B+Tree（B+树）

# 算法

## 排序

#### 0.1 算法分类** **

十种常见排序算法可以分为两大类：

- **比较类排序**：通过比较来决定元素间的相对次序，由于其时间复杂度不能突破O(nlogn)，因此也称为非线性时间比较类排序。
- **非比较类排序**：不通过比较来决定元素间的相对次序，它可以突破基于比较排序的时间下界，以线性时间运行，因此也称为线性时间非比较类排序。 

![排序算法](static/db/%E6%8E%92%E5%BA%8F%E7%AE%97%E6%B3%95.png)

#### 0.2 算法复杂度

![排序算法时间复杂度](static/db/%E6%8E%92%E5%BA%8F%E7%AE%97%E6%B3%95%E6%97%B6%E9%97%B4%E5%A4%8D%E6%9D%82%E5%BA%A6.png)

#### **0.3 相关概念**

- **稳定**：如果a原本在b前面，而a=b，排序之后a仍然在b的前面。
- **不稳定**：如果a原本在b的前面，而a=b，排序之后 a 可能会出现在 b 的后面。
- **时间复杂度**：对排序数据的总的操作次数。反映当n变化时，操作次数呈现什么规律。
- **空间复杂度：**是指算法在计算机

内执行时所需存储空间的度量，它也是数据规模n的函数。 

### 1、冒泡排序（Bubble Sort）

冒泡排序是一种简单的排序算法。它重复地走访过要排序的数列，一次比较两个元素，如果它们的顺序错误就把它们交换过来。走访数列的工作是重复地进行直到没有再需要交换，也就是说该数列已经排序完成。这个算法的名字由来是因为越小的元素会经由交换慢慢“浮”到数列的顶端。 

#### 1.1 算法描述

- 比较相邻的元素。如果第一个比第二个大，就交换它们两个；
- 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对，这样在最后的元素应该会是最大的数；
- 针对所有的元素重复以上的步骤，除了最后一个；
- 重复步骤1~3，直到排序完成。

#### **1.2 动图演示**

![冒泡排序](static/db/%E5%86%92%E6%B3%A1%E6%8E%92%E5%BA%8F.gif)

#### 1.3 代码实现

> ```php
> function bubbleSort(arr) {
>     var len = arr.length;
>     for(var i = 0; i < len - 1; i++) {
>         for(var j = 0; j < len - 1 - i; j++) {
>             if(arr[j] > arr[j+1]) {        // 相邻元素两两对比
>                 var temp = arr[j+1];        // 元素交换
>                 arr[j+1] = arr[j];
>                 arr[j] = temp;
>             }
>         }
>     }
>     returnarr;
> }
> ```



### 2、快速排序（Quick Sort）

快速排序的基本思想：通过一趟排序将待排记录分隔成独立的两部分，其中一部分记录的关键字均比另一部分的关键字小，则可分别对这两部分记录继续进行排序，以达到整个序列有序。

#### 6.1 算法描述

快速排序使用分治法来把一个串（list）分为两个子串（sub-lists）。具体算法描述如下：

- 从数列中挑出一个元素，称为 “基准”（pivot）；
- 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区退出之后，该基准就处于数列的中间位置。这个称为分区（partition）操作；
- 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。

#### 6.2 动图演示

![快速排序](static/db/%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F.gif)

#### 6.3 代码实现

> ```php
> function quickSort(arr, left, right) {
>  varlen = arr.length,
>      partitionIndex,
>      left = typeofleft != 'number'? 0 : left,
>      right = typeofright != 'number'? len - 1 : right;
> 
>  if(left < right) {
>      partitionIndex = partition(arr, left, right);
>      quickSort(arr, left, partitionIndex-1);
>      quickSort(arr, partitionIndex+1, right);
>  }
>  returnarr;
> }
> 
> function partition(arr, left ,right) {     // 分区操作
>  varpivot = left,                      // 设定基准值（pivot）
>      index = pivot + 1;
>  for(vari = index; i <= right; i++) {
>      if(arr[i] < arr[pivot]) {
>          swap(arr, i, index);
>          index++;
>      }       
>  }
>  swap(arr, pivot, index - 1);
>  returnindex-1;
> }
> 
> function swap(arr, i, j) {
>  vartemp = arr[i];
>  arr[i] = arr[j];
>  arr[j] = temp;
> }
> ```



### 3、插入排序（Insertion Sort）

插入排序（Insertion-Sort）的算法描述是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。

#### 3.1 算法描述

一般来说，插入排序都采用in-place在数组上实现。具体算法描述如下：

- 从第一个元素开始，该元素可以认为已经被排序；
- 取出下一个元素，在已经排序的元素序列中从后向前扫描；
- 如果该元素（已排序）大于新元素，将该元素移到下一位置；
- 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置；
- 将新元素插入到该位置后；
- 重复步骤2~5。

#### 3.2 动图演示

![插入排序](static/db/%E6%8F%92%E5%85%A5%E6%8E%92%E5%BA%8F.gif)

#### 3.2 代码实现

> ```php
> function insertionSort(arr) {
>     varlen = arr.length;
>     varpreIndex, current;
>     for(vari = 1; i < len; i++) {
>         preIndex = i - 1;
>         current = arr[i];
>         while(preIndex >= 0 && arr[preIndex] > current) {
>             arr[preIndex + 1] = arr[preIndex];
>             preIndex--;
>         }
>         arr[preIndex + 1] = current;
>     }
>     returnarr;
> }
> ```
>
> 

#### 3.4 算法分析

插入排序在实现上，通常采用in-place排序（即只需用到O(1)的额外空间的排序），因而在从后向前扫描过程中，需要反复把已排序元素逐步向后挪位，为最新元素提供插入空间。

### 4、希尔排序（Shell Sort）

1959年Shell发明，第一个突破O(n2)的排序算法，是简单插入排序的改进版。它与插入排序的不同之处在于，它会优先比较距离较远的元素。希尔排序又叫**缩小增量排序**。

#### 4.1 算法描述

先将整个待排序的记录序列分割成为若干子序列分别进行直接插入排序，具体算法描述：

- 选择一个增量序列t1，t2，…，tk，其中ti>tj，tk=1；
- 按增量序列个数k，对序列进行k 趟排序；
- 每趟排序，根据对应的增量ti，将待排序列分割成若干长度为m 的子序列，分别对各子表进行直接插入排序。仅增量因子为1 时，整个序列作为一个表来处理，表长度即为整个序列的长度。

#### 4.2 动图演示

![希尔排序](static/db/%E5%B8%8C%E5%B0%94%E6%8E%92%E5%BA%8F.gif)

#### 4.3 代码实现

> ```php
> function shellSort(arr) {
>     varlen = arr.length;
>     for(vargap = Math.floor(len / 2); gap > 0; gap = Math.floor(gap / 2)) {
>         // 注意：这里和动图演示的不一样，动图是分组执行，实际操作是多个分组交替执行
>         for(vari = gap; i < len; i++) {
>             varj = i;
>             varcurrent = arr[i];
>             while(j - gap >= 0 && current < arr[j - gap]) {
>                  arr[j] = arr[j - gap];
>                  j = j - gap;
>             }
>             arr[j] = current;
>         }
>     }
>     returnarr;
> }
> ```
>
> 

#### 4.4 算法分析

希尔排序的核心在于间隔序列的设定。既可以提前设定好间隔序列，也可以动态的定义间隔序列。动态定义间隔序列的算法是《算法（第4版）》的合著者Robert Sedgewick提出的。　

### 5、选择排序（Selection Sort）

选择排序(Selection-sort)是一种简单直观的排序算法。它的工作原理：首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置，然后，再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。以此类推，直到所有元素均排序完毕。 

#### 2.1 算法描述

n个记录的直接选择排序可经过n-1趟直接选择排序得到有序结果。具体算法描述如下：

- 初始状态：无序区为R[1..n]，有序区为空；
- 第i趟排序(i=1,2,3…n-1)开始时，当前有序区和无序区分别为R[1..i-1]和R(i..n）。该趟排序从当前无序区中-选出关键字最小的记录 R[k]，将它与无序区的第1个记录R交换，使R[1..i]和R[i+1..n)分别变为记录个数增加1个的新有序区和记录个数减少1个的新无序区；
- n-1趟结束，数组有序化了。

#### **2.2 动图演示**

　　![选择排序](static/db/%E9%80%89%E6%8B%A9%E6%8E%92%E5%BA%8F.gif)

#### 2.3 代码实现

> ```php
> function selectionSort(arr) {
>  varlen = arr.length;
>  varminIndex, temp;
>  for(vari = 0; i < len - 1; i++) {
>      minIndex = i;
>      for(varj = i + 1; j < len; j++) {
>          if(arr[j] < arr[minIndex]) {     // 寻找最小的数
>              minIndex = j;                 // 将最小数的索引保存
>          }
>      }
>      temp = arr[i];
>      arr[i] = arr[minIndex];
>      arr[minIndex] = temp;
>  }
>  returnarr;
> }
> ```
>
> 

#### 2.4 算法分析

表现最稳定的排序算法之一，因为无论什么数据进去都是O(n2)的时间复杂度，所以用到它的时候，数据规模越小越好。唯一的好处可能就是不占用额外的内存空间了吧。理论上讲，选择排序可能也是平时排序一般人想到的最多的排序方法了吧。





### 6、堆排序（Heap Sort）

堆排序（Heapsort）是指利用堆这种数据结构所设计的一种排序算法。堆积是一个近似完全二叉树的结构，并同时满足堆积的性质：即子结点的键值或索引总是小于（或者大于）它的父节点。

#### 7.1 算法描述

- 将初始待排序关键字序列(R1,R2….Rn)构建成大顶堆，此堆为初始的无序区；
- 将堆顶元素R[1]与最后一个元素R[n]交换，此时得到新的无序区(R1,R2,……Rn-1)和新的有序区(Rn),且满足R[1,2…n-1]<=R[n]；
- 由于交换后新的堆顶R[1]可能违反堆的性质，因此需要对当前无序区(R1,R2,……Rn-1)调整为新堆，然后再次将R[1]与无序区最后一个元素交换，得到新的无序区(R1,R2….Rn-2)和新的有序区(Rn-1,Rn)。不断重复此过程直到有序区的元素个数为n-1，则整个排序过程完成。

#### 7.2 动图演示

![堆排序](static/db/%E5%A0%86%E6%8E%92%E5%BA%8F.gif)

#### 7.3 代码实现

> ```php
> varlen;    // 因为声明的多个函数都需要数据长度，所以把len设置成为全局变量
>  
> function buildMaxHeap(arr) {   // 建立大顶堆
>     len = arr.length;
>     for(vari = Math.floor(len/2); i >= 0; i--) {
>         heapify(arr, i);
>     }
> }
>  
> function heapify(arr, i) {     // 堆调整
>     varleft = 2 * i + 1,
>         right = 2 * i + 2,
>         largest = i;
>  
>     if(left < len && arr[left] > arr[largest]) {
>         largest = left;
>     }
>  
>     if(right < len && arr[right] > arr[largest]) {
>         largest = right;
>     }
>  
>     if(largest != i) {
>         swap(arr, i, largest);
>         heapify(arr, largest);
>     }
> }
>  
> function swap(arr, i, j) {
>     vartemp = arr[i];
>     arr[i] = arr[j];
>     arr[j] = temp;
> }
>  
> function heapSort(arr) {
>     buildMaxHeap(arr);
>  
>     for(vari = arr.length - 1; i > 0; i--) {
>         swap(arr, 0, i);
>         len--;
>         heapify(arr, 0);
>     }
>     returnarr;
> }
> ```
>
> 

### 7、归并排序（Merge Sort）

归并排序是建立在归并操作上的一种有效的排序算法。该算法是采用分治法（Divide and Conquer）的一个非常典型的应用。将已有序的子序列合并，得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。若将两个有序表合并成一个有序表，称为2-路归并。 

#### 5.1 算法描述

- 把长度为n的输入序列分成两个长度为n/2的子序列；
- 对这两个子序列分别采用归并排序；
- 将两个排序好的子序列合并成一个最终的排序序列。

#### 5.2 动图演示

![归并排序](static/db/%E5%BD%92%E5%B9%B6%E6%8E%92%E5%BA%8F.gif)

#### 5.3 代码实现

> ```php
> function mergeSort(arr) {
>  varlen = arr.length;
>  if(len < 2) {
>      returnarr;
>  }
>  varmiddle = Math.floor(len / 2),
>      left = arr.slice(0, middle),
>      right = arr.slice(middle);
>  returnmerge(mergeSort(left), mergeSort(right));
> }
> 
> function merge(left, right) {
>  varresult = [];
> 
>  while(left.length>0 && right.length>0) {
>      if(left[0] <= right[0]) {
>          result.push(left.shift());
>      } else{
>          result.push(right.shift());
>      }
>  }
> 
>  while(left.length)
>      result.push(left.shift());
> 
>  while(right.length)
>      result.push(right.shift());
> 
>  returnresult;
> }
> ```
>
> 

#### 5.4 算法分析

归并排序是一种稳定的排序方法。和选择排序一样，归并排序的性能不受输入数据的影响，但表现比选择排序好的多，因为始终都是O(nlogn）的时间复杂度。代价是需要额外的内存空间。

### 8、计数排序（Counting Sort）

计数排序不是基于比较的排序算法，其核心在于将输入的数据值转化为键存储在额外开辟的数组空间中。 作为一种线性时间复杂度的排序，计数排序要求输入的数据必须是有确定范围的整数。

#### 8.1 算法描述

- 找出待排序的数组中最大和最小的元素；
- 统计数组中每个值为i的元素出现的次数，存入数组C的第i项；
- 对所有的计数累加（从C中的第一个元素开始，每一项和前一项相加）；
- 反向填充目标数组：将每个元素i放在新数组的第C(i)项，每放一个元素就将C(i)减去1。

#### 8.2 动图演示

![计数排序](static/db/%E8%AE%A1%E6%95%B0%E6%8E%92%E5%BA%8F.gif)

#### 8.3 代码实现

> ```php
> function countingSort(arr, maxValue) {
>     varbucket = newArray(maxValue + 1),
>         sortedIndex = 0;
>         arrLen = arr.length,
>         bucketLen = maxValue + 1;
>  
>     for(vari = 0; i < arrLen; i++) {
>         if(!bucket[arr[i]]) {
>             bucket[arr[i]] = 0;
>         }
>         bucket[arr[i]]++;
>     }
>  
>     for(varj = 0; j < bucketLen; j++) {
>         while(bucket[j] > 0) {
>             arr[sortedIndex++] = j;
>             bucket[j]--;
>         }
>     }
>  
>     returnarr;
> }
> ```
>
> 

#### 8.4 算法分析

计数排序是一个稳定的排序算法。当输入的元素是 n 个 0到 k 之间的整数时，时间复杂度是O(n+k)，空间复杂度也是O(n+k)，其排序速度快于任何比较排序算法。当k不是很大并且序列比较集中时，计数排序是一个很有效的排序算法。

### 9、桶排序（Bucket Sort）

桶排序是计数排序的升级版。它利用了函数的映射关系，高效与否的关键就在于这个映射函数的确定。桶排序 (Bucket sort)的工作的原理：假设输入数据服从均匀分布，将数据分到有限数量的桶里，每个桶再分别排序（有可能再使用别的排序算法或是以递归方式继续使用桶排序进行排）。

#### 9.1 算法描述

- 设置一个定量的数组当作空桶；
- 遍历输入数据，并且把数据一个一个放到对应的桶里去；
- 对每个不是空的桶进行排序；
- 从不是空的桶里把排好序的数据拼接起来。 

#### 9.2 图片演示

![img](https://images2017.cnblogs.com/blog/849589/201710/849589-20171015232107090-1920702011.png)

#### 9.3 代码实现

> ```php
> function bucketSort(arr, bucketSize) {
>     if(arr.length === 0) {
>       returnarr;
>     }
>  
>     vari;
>     varminValue = arr[0];
>     varmaxValue = arr[0];
>     for(i = 1; i < arr.length; i++) {
>       if(arr[i] < minValue) {
>           minValue = arr[i];                // 输入数据的最小值
>       } elseif(arr[i] > maxValue) {
>           maxValue = arr[i];                // 输入数据的最大值
>       }
>     }
>  
>     // 桶的初始化
>     varDEFAULT_BUCKET_SIZE = 5;            // 设置桶的默认数量为5
>     bucketSize = bucketSize || DEFAULT_BUCKET_SIZE;
>     varbucketCount = Math.floor((maxValue - minValue) / bucketSize) + 1;  
>     varbuckets = newArray(bucketCount);
>     for(i = 0; i < buckets.length; i++) {
>         buckets[i] = [];
>     }
>  
>     // 利用映射函数将数据分配到各个桶中
>     for(i = 0; i < arr.length; i++) {
>         buckets[Math.floor((arr[i] - minValue) / bucketSize)].push(arr[i]);
>     }
>  
>     arr.length = 0;
>     for(i = 0; i < buckets.length; i++) {
>         insertionSort(buckets[i]);                      // 对每个桶进行排序，这里使用了插入排序
>         for(varj = 0; j < buckets[i].length; j++) {
>             arr.push(buckets[i][j]);                     
>         }
>     }
>  
>     returnarr;
> }
> ```
>
> 

#### 9.4 算法分析

桶排序最好情况下使用线性时间O(n)，桶排序的时间复杂度，取决与对各个桶之间数据进行排序的时间复杂度，因为其它部分的时间复杂度都为O(n)。很显然，桶划分的越小，各个桶之间的数据越少，排序所用的时间也会越少。但相应的空间消耗就会增大。 

### 10、基数排序（Radix Sort）

基数排序是按照低位先排序，然后收集；再按照高位排序，然后再收集；依次类推，直到最高位。有时候有些属性是有优先级顺序的，先按低优先级排序，再按高优先级排序。最后的次序就是高优先级高的在前，高优先级相同的低优先级高的在前。

#### 10.1 算法描述

- 取得数组中的最大数，并取得位数；
- arr为原始数组，从最低位开始取每个位组成radix数组；
- 对radix进行计数排序（利用计数排序适用于小范围数的特点）；

#### 10.2 动图演示

![基数排序](static/db/%E5%9F%BA%E6%95%B0%E6%8E%92%E5%BA%8F.gif)

#### 10.3 代码实现

> ```php
> varcounter = [];
> function radixSort(arr, maxDigit) {
>     varmod = 10;
>     vardev = 1;
>     for(vari = 0; i < maxDigit; i++, dev *= 10, mod *= 10) {
>         for(varj = 0; j < arr.length; j++) {
>             varbucket = parseInt((arr[j] % mod) / dev);
>             if(counter[bucket]==null) {
>                 counter[bucket] = [];
>             }
>             counter[bucket].push(arr[j]);
>         }
>         varpos = 0;
>         for(varj = 0; j < counter.length; j++) {
>             varvalue = null;
>             if(counter[j]!=null) {
>                 while((value = counter[j].shift()) != null) {
>                       arr[pos++] = value;
>                 }
>           }
>         }
>     }
>     returnarr;
> }
> ```
>
> 

#### 10.4 算法分析

基数排序基于分别排序，分别收集，所以是稳定的。但基数排序的性能比桶排序要略差，每一次关键字的桶分配都需要O(n)的时间复杂度，而且分配之后得到新的关键字序列又需要O(n)的时间复杂度。假如待排数据可以分为d个关键字，则基数排序的时间复杂度将是O(d*2n) ，当然d要远远小于n，因此基本上还是线性级别的。

基数排序的空间复杂度为O(n+k)，其中k为桶的数量。一般来说n>>k，因此额外空间需要大概n个左右。

# 问题

## (一)、缓存穿透

缓存穿透是指查询一个一定不存在的数据，因为这个数据不存在，所以永远不会被缓存，所以每次请求都会去请求数据库。

## (二)、缓存穿刺

当热点KEY在失效的瞬间，海量的请求会不会产生大量的数据库请求，从而导致数据库崩溃？



### 1、互斥锁

互斥锁指的是在缓存KEY过期去更新的时候，先让程序去获取锁，只有获取到锁的线程才有资格去更新缓存KEY

## (三)、缓存雪崩

缓存雪崩是指在我们设置缓存时采用了相同的过期时间，导致缓存在某一时刻同时失效，请求全部转发到数据库，最终导致数据库瞬时压力过大而崩溃。