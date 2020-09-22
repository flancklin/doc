# mysql

## 数据引擎(表)

>| 特点     | MyISAM | InnoDB   | MEMORY | MERGE | NDB  |
>| -------- | ------ | -------- | ------ | ----- | ---- |
>| 数据结构 | B+树   | B+树     | hash   |       |      |
>| 事务     |        | 支持     |        |       |      |
>| 锁       | 表锁   | 表+行锁  | 表锁   | 表锁  | 表锁 |
>| 外键     |        | 支持     |        |       |      |
>| 全文索引 | 支持   | 5.6+支持 |        |       |      |

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

## 冒泡排序

## 快速排序

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
>     varlen = arr.length;
>     for(vari = 0; i < len - 1; i++) {
>         for(varj = 0; j < len - 1 - i; j++) {
>             if(arr[j] > arr[j+1]) {        // 相邻元素两两对比
>                 vartemp = arr[j+1];        // 元素交换
>                 arr[j+1] = arr[j];
>                 arr[j] = temp;
>             }
>         }
>     }
>     returnarr;
> }
> ```

### 2、选择排序（Selection Sort）

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
>     varlen = arr.length;
>     varminIndex, temp;
>     for(vari = 0; i < len - 1; i++) {
>         minIndex = i;
>         for(varj = i + 1; j < len; j++) {
>             if(arr[j] < arr[minIndex]) {     // 寻找最小的数
>                 minIndex = j;                 // 将最小数的索引保存
>             }
>         }
>         temp = arr[i];
>         arr[i] = arr[minIndex];
>         arr[minIndex] = temp;
>     }
>     returnarr;
> }
> ```
>
> 

#### 2.4 算法分析

表现最稳定的排序算法之一，因为无论什么数据进去都是O(n2)的时间复杂度，所以用到它的时候，数据规模越小越好。唯一的好处可能就是不占用额外的内存空间了吧。理论上讲，选择排序可能也是平时排序一般人想到的最多的排序方法了吧。

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

### 5、归并排序（Merge Sort）

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
>     varlen = arr.length;
>     if(len < 2) {
>         returnarr;
>     }
>     varmiddle = Math.floor(len / 2),
>         left = arr.slice(0, middle),
>         right = arr.slice(middle);
>     returnmerge(mergeSort(left), mergeSort(right));
> }
>  
> function merge(left, right) {
>     varresult = [];
>  
>     while(left.length>0 && right.length>0) {
>         if(left[0] <= right[0]) {
>             result.push(left.shift());
>         } else{
>             result.push(right.shift());
>         }
>     }
>  
>     while(left.length)
>         result.push(left.shift());
>  
>     while(right.length)
>         result.push(right.shift());
>  
>     returnresult;
> }
> ```
>
> 

#### 5.4 算法分析

归并排序是一种稳定的排序方法。和选择排序一样，归并排序的性能不受输入数据的影响，但表现比选择排序好的多，因为始终都是O(nlogn）的时间复杂度。代价是需要额外的内存空间。

### 6、快速排序（Quick Sort）

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
>     varlen = arr.length,
>         partitionIndex,
>         left = typeofleft != 'number'? 0 : left,
>         right = typeofright != 'number'? len - 1 : right;
>  
>     if(left < right) {
>         partitionIndex = partition(arr, left, right);
>         quickSort(arr, left, partitionIndex-1);
>         quickSort(arr, partitionIndex+1, right);
>     }
>     returnarr;
> }
>  
> function partition(arr, left ,right) {     // 分区操作
>     varpivot = left,                      // 设定基准值（pivot）
>         index = pivot + 1;
>     for(vari = index; i <= right; i++) {
>         if(arr[i] < arr[pivot]) {
>             swap(arr, i, index);
>             index++;
>         }       
>     }
>     swap(arr, pivot, index - 1);
>     returnindex-1;
> }
>  
> function swap(arr, i, j) {
>     vartemp = arr[i];
>     arr[i] = arr[j];
>     arr[j] = temp;
> }
> ```

### 7、堆排序（Heap Sort）

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