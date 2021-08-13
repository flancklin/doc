# 运行php和包要求php版本不一致

>
>
>linux环境运行php：7.3.5
>
>项目中composer.json定义php：>=5.4.0
>
> 
>
>问题：运行项目，提示出现了php8版本的语法，不支持
>
>![image-20210812093757045](C:\Users\EDZ\Desktop\doc\md\composer.assets\image-20210812093757045.png)
>
>  
>
>解决：
>
>改掉composer.json中指定的版本号即可

# 包冲突

>
>
>在项目中用到a和b两个包
>
>* a包引用包c：~1.2.0
>* b包引用包c：~2.1.0
>
>怎么解决？





# 降低到指定版本

> ```sh
> composer self-update --help
> composer self-update --1
> ```
>
> 

# composer存储库

https://packagist.org/

账号：flancklin

邮件：47@qq.com

密码：F4composer

```json
{
  "name": "【[发布]】包的名字。由供应方（vendor）名和项目名组成，用 / 分隔。==在发布包的时候需要填==",
  "description": "【[发布]】对包的一个简短描述，通常是一行的长度。==在发布包的时候需要填==",
  "version": "包的版本。格式必须是 X.Y.Z，选择性后缀：-dev、-alphaN、-betaN、-RCN",
  "type": "包的类型，默认为 library。==包类型用于定制安装逻辑==。如果你的包的安装需要一些特殊的逻辑，你可以定义一个定制的类型。它可以是一个 symfony-bundle 的类型，或者 wordpress-plugin，或者 typo3-module。这些类型将被特定的项目所用，它们将提供安装器来安装这些类型的包",
  "keywords": "【[可选]】一个与包相关的关键词数组。用于包的搜索和过滤。可选",
  "homepage": "【[可选]】项目的网站 URL",
  "license": "【[可选]】包的许可证。可以是字符串或字符串数组。可选，但强烈建议加上",
  "time": "【[可选]】版本发布时间.必须是 YYYY-MM-DD 或 YYYY-MM-DD HH:MM:SS 格式",
  "authors": {
    "name": "作者名字",
    "email": "作者邮箱",
    "homepage": "作者网站 URL",
    "role": "作者在项目中的角色（如：developer 或 translator）"
  },
  "support": {
    "email": "获取支持的邮箱",
    "issues": "问题跟踪的 URL",
    "forum": "论坛的 URL",
    "wiki": "Wiki 的 URL",
    "irc": "IRC 的频道",
    "source": "查看或下载源码的 URL"
  },
  "require": {"包名": "版本号","": ""},
  "require-dev": {"包名": "版本号","": ""},
  "": "",
  "": "",
  "": "",
  "": "",
  "": ""
}
```

