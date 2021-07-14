# 官网：https://git-scm.com/docs

# 一、安装及信息

## (一)、版本号

> ```shell
> git --version
> ```

## (二)、帮助文档及查看全部指令

> 查看全部指令

> ```shelll
> git help
> git help -a #查看全部命令（包括子命令）
> ```



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

>
>
>```sh
>cd baidu
>git init
>git remote add origin https://github.com/yourName/baidu.git
>touch a.txt    #不能创建空文件夹，git status搜不到
>git commit -a "第一次提交" 
>git push origin master
>```
>
>

#### (2)、git clone

##### (a)、git clone直接使用账号密码

>格式
>
>```shell
>git clone https://username:password@链接
>```
>
>示例
>
>```shell
>#复制下来的链接为： https://gitee.com/flancklin/flancklin.git
>$ git clone https://flancklin:Feng1234@gitee.com/flancklin/flancklin.git
>```

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

##### 撤销合并操作

> ```sh
>  git merge --abort 
> ```
>
> 

#### (3)、恢复已删除得分支

# 三、远程库

fetch+merge=pull

git remote -v

# git config

## (一)、查看【当前项目配置】与【全局配置】

当前项目配置

>```shell
>git config --list
>```

全局配置

> ```shell
> git config --global --list
> ```

## (二)、增加修改参数

> ```shell
> git config [--global] key value
> ```

## (三)、删除参数--unset

> ```shell
> git config [--global] --unset key
> ```

# 问题解决

## (一)、GUI界面显示乱码

>![image-20210202161627716](static/git/image-20210202161627716.png)
>
>

### 解决方法：

>在乱码的区域点击鼠标右键，选择Encoding，然后选择Unicode（UTF-8），乱码问题解决：

git bash界面乱码问题

## (二)、BASH界面显示乱码

>![image-20210303115148698](static/git/image-20210303115148698.png)
>
>1、在bash框内。右键->options->text->character set->GBK（windows不是utf8,而是GBK）

## (三)、查询历史执行过的git指令

## (四)、一台电脑保存多个git账号

场景：

>```shell
>在github.com有账号；
>在gitee.com有账号；
>还有公司账号，还有其他外包业务账号。。。。
>```

### 1、方法1(ssh)

#### (1)、思路方向

>```
>每个账号创建一套ssh密钥
>在github/gitee上绑定个自的ssh.pub
>把所有创建的密钥加入到ssh中
>为ssh创建config
>```

#### (2)、步骤

>1.准备工作
>
>> ```shell
>> $ ssh-add -l #出现下面的需要执行 $ ssh-agent bash
>> Could not open a connection to your authentication agent.
>
>> $ ssh-agent bash
>
>> $ ssh-add -l #查看当前有哪些密钥
>> The agent has no identities.
>
>> $ ssh-add -d my_id_rsa #删除某个密钥。文件的绝对路径或相对路径
>> Identity removed: my_id_rsa (475185283@qq.com)
>
>> 找到.ssh文件路径。后面是基于.ssh路径操作的
>>
>> ```
>
>2.生成密钥
>
>> ```shell
>> #                     密钥的备注名称         密钥的文件名称 
>> $ ssh-keygen -t rsa -C "github" -f ~/.ssh/id_rsa_github
>> $ ssh-keygen -t rsa -C "gitee" -f ~/.ssh/id_rsa_gitee
>> ```
>
>3.登录gitee，把id_rsa_gitee.pub绑定；登录github，把id_rsa_github.pub绑定
>
>> ```shell
>> 账号 > setting > ssh
>> ```
>
>4.把新创建的密钥加入到ssh
>
>> ```shell
>> $ ssh-add ~/.ssh/id_rsa_github
>> Identity added: /c/Users/EDZ/.ssh/id_rsa_github (github)
>
>> $ ssh-add ~/.ssh/id_rsa_gitee
>> Identity added: /c/Users/EDZ/.ssh/id_rsa_gitee (gitee)
>
>> $ ssh-add -l
>> 3072 SHA256:kZQ/ePScCm+yQb8r9WBkCZ6zHd/GZsmCb4z1hugcmm0 github (RSA)
>> 3072 SHA256:Cer6J7DsgqEVfdr1gWvuN/JcKoLVFl/xTmudHiMdLhE gitee (RSA)
>>
>> ```
>
>5.把密钥配置到config文件
>
>> ```shell
>> $ vim ~/.ssh/config
>> #内容
>> host 标签(别名)
>> hostname 网站地址
>> IdentityFile rsa文件路径
>> #--------------------------------------
>
>> # gitee
>> Host gitee
>> Hostname gitee.com
>> #User
>> IdentityFile ~/.ssh/id_rsa_gitee
>
>> # github
>> Host github
>> Hostname github.com
>> #User
>> IdentityFile ~/.ssh/id_rsa_github
>>
>> ```
>
>6.测试是否正确
>
>> ```shell
>> $  ssh -T git@github
>> The authenticity of host 'github.com (52.74.223.119)' can't be established.
>> RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
>> Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
>> Warning: Permanently added 'github.com,52.74.223.119' (RSA) to the list of known hosts.
>> Hi flancklin! You've successfully authenticated, but GitHub does not provide shell access.
>
>> EDZ@DESKTOP-OBUBLTV MINGW64 ~/.ssh
>> $  ssh -T git@gitee
>> The authenticity of host 'gitee.com (180.97.125.228)' can't be established.
>> ECDSA key fingerprint is SHA256:FQGC9Kn/eye1W8icdBgrQp+KkGYoFgbVr17bmjey0Wc.
>> Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
>> Warning: Permanently added 'gitee.com,180.97.125.228' (ECDSA) to the list of known hosts.
>> Hi 百里杨周! You've successfully authenticated, but GITEE.COM does not provide shell access.
>>
>> ```

#### (3)、后续问题

判断git remote使用的是否有ssh链接

> ```shell
> EDZ@DESKTOP-OBUBLTV MINGW64 /c/code/flancklin-note/doc (master)
> $ git remote -v
> origin  https://github.com/flancklin/doc.git (fetch)
> origin  https://github.com/flancklin/doc.git (push)
> ```
>
> ===这个是https链接。不是ssh链接==

添加ssh链接

> ```shell
> EDZ@DESKTOP-OBUBLTV MINGW64 /c/code/mayun/flancklin (master)
> $ git remote add origin_ssh git@gitee.com:flancklin/flancklin.git
> origin  https://flancklin:Feng1234my@gitee.com/flancklin/flancklin.git (fetch)
> origin  https://flancklin:Feng1234my@gitee.com/flancklin/flancklin.git (push)
> 
> EDZ@DESKTOP-OBUBLTV MINGW64 /c/code/mayun/flancklin (master)
> $ git remote -v
> origin  https://flancklin:Feng1234my@gitee.com/flancklin/flancklin.git (fetch)
> origin  https://flancklin:Feng1234my@gitee.com/flancklin/flancklin.git (push)
> origin_ssh      git@gitee.com:flancklin/flancklin.git (fetch)
> origin_ssh      git@gitee.com:flancklin/flancklin.git (push)
> 
> ```

删除多余的remote

> ```shell
> $ git remote rm origin
> ```

## (五)、gitHub

### 1、git clone https(443:Timed out)

>
>
>![image-20210303145426265](static/git/image-20210303145426265.png)
>
>尝试了网上的【git config --global http.proxy "localhost:1080”】，但没有效果。
>
>最终没有用http链接了。专用SSH下载

### 2、ping github.com找不到主机

>![image-20210303114124010](static/git/image-20210303114124010.png)
>
>1、打开网址 https://www.ipaddress.com/
>
>​		输入 github.com 或者 github.global.ssl.fastly.net
>
> 
>
>2、将得到的ip地址放入到host文件中
>
> 
>
>3、用管理员权限(Win10)打开 C:\Windows\System32\drivers\etc 目录下的 host文件
>
>在文件末尾加上
>
> 
>
>192.30.253.112 github.com
>151.101.88.249 github.global.ssl.fastly.net
>
> 
>
>4、然后再win+r,输入ipconfig刷新即可

### 3、Your requirements could not be resolved to an installable set of packages

>
>
>![image-20210331160952873](static/git/image-20210331160952873.png)

解决方法：

>
>
>一、先确定当前使用得是那个仓库源
>
>```
>1、查看composer.json中是否设置了repositories.url
>2、查看当前项目环境是否设置了repositories.url
>3、查看全局环境是否设置了repositories.url
>```
>
>二、去当前得仓库源得官网查看这些项目是否真实存在
>
>



## (六)、gitee

## （七)、gitignore

### 1、问题1：a文件以前在版本控制，现在想移除

>
>
>1、把需要移除的文件放在.gitignore文件中
>
>2、执行git update-index --assume-unchanged 文件
>
>3、执行commit-push（这里提交的是.gitignore文件）
>
>* 被移除的文件，在步骤3中就已经不会出现了。
>* 本地可以只执行1、2.不用去提交影响线上

