# 一、安装及信息

## (一)、版本号

> ```shell
> git version
> ```

## (二)、帮助文档

> 不是cli显示文档，是本地html文档
>
> ```shell
> git command --help
> git help command
> ```

## (三)、签名

#### 1、本地全局签名

> ```shell
> #查看全局签名
> git config --global --list
> #设置全局签名user.name
> git config --global user.name flancklin
> #设置全局签名user.email
> git config --global user.email 475185283@qq.com
> ```

#### 1、项目签名

> ```shell
> #查看全局签名
> git config --list
> #设置全局签名user.name
> git config user.name flancklin
> #设置全局签名user.email
> git config user.email 475185283@qq.com
> ```

## (四)、.gitignore文件

 

> ```
> # 忽略所有的 .a 文件
> *.a
> 
> # 但跟踪所有的 lib.a，即便你在前面忽略了 .a 文件
> !lib.a
> 
> # 只忽略当前目录下的 TODO 文件，而不忽略 subdir/TODO
> /TODO
> 
> # 忽略任何目录下名为 build 的文件夹
> build/
> 
> # 忽略 doc/notes.txt，但不忽略 doc/server/arch.txt
> doc/*.txt
> 
> # 忽略 doc/ 目录及其所有子目录下的 .pdf 文件
> doc/**/*.pdf
> ```

 

# 二、本地库

### 1、创建本地库

#### (1)、git init

#### (2)、git clone

### 2、分支内

#### (1)、提交与立即撤回

version:2.24.0 windows.2

![image-20210202155218449](static/git/image-20210202155218449.png)

#### (2)、历史提交记录

> 【git log】 、【git reflog】【与more指令一样】
>
> 上翻页（空格）；
>
> 下翻译（b）；
>
> 下一行（enter）;
>
> 退出（q）；
>
> 查找（没有）；

##### (a)、git log

>| 参数        | 作用             | 备注             |
>| ----------- | ---------------- | ---------------- |
>| --oneline   | 简洁显示         |                  |
>| -n <number> | 只输出最新得几行 | 不再支持上下翻页 |
>
>```shell
>#git log
>Author: fengjinliang <fengjinliang@streamhub.tech>
>Date:   Mon Feb 1 15:25:24 2021 +0800
>
>    多个订阅策略(收集策略)只能同时开启一个
>    Signed-off-by: fengjinliang <fengjinliang@streamhub.tech>
>
>commit 44cc5d58db16c83fe65a1e4e386678431a652f84
>```
>
>```shell
>#git log --oneline
>0746245 bug
>76d1308 收集策略默认值
>```

##### (b)、git reflog

>reflog多一个==版本回退需要的步数==
>
>```shell
>d80bc3f HEAD@{13}: commit: stream-url不要斜杠
>369288b HEAD@{14}: commit: 导数据给harbor
>62ff765 HEAD@{15}: commit: 默认打开【edm 无加购30分钟】
>
>```

#### (3)、版本前进与回退

| 参数    | 区别                                               | 备注 |
| ------- | -------------------------------------------------- | ---- |
| --soft  | 仅改变了【本地库】的版本                           |      |
| --mixed | 仅改变了【本地库】【暂存区】的版本                 |      |
| --hard  | 改变了【本地库】【暂存区】【工作取】的版本。全改了 |      |

##### (a)、git reset --hard 版本ID

##### (b)、git reset --hard HEAD^

> ​	^的个数表示回退步数
>
> ==回退成功后，git log是没有【未来的记录】==

##### (c)、git reset --hard HEAD~2

>符号~后面直接跟回退步数
>
>==回退成功后，git log是没有【未来的记录】==

#### (4)、文件恢复

#### (5)、文件比较

### 3、跨分支

#### (1)、分支增删改查+切换

#### (2)、合并分支

#### (3)、恢复已删除得分支

# 三、远程库

fetch+merge=pull

git remote -v