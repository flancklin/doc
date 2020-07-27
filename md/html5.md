# 语法



## 注释

注释的写法      

>`<!-- 我是注释 -->`



## 全局属性

所谓全局属性就是全部标签都可以使用的属性

| 属性                                                         | 描述                                                   | 取值                     |
| :----------------------------------------------------------- | :----------------------------------------------------- | ------------------------ |
| [id](https://www.w3school.com.cn/tags/att_standard_id.asp)   | 自定义唯一ID                                           | string                   |
| [class](https://www.w3school.com.cn/tags/att_standard_class.asp) | class_name                                             | string                   |
| [style](https://www.w3school.com.cn/tags/att_standard_style.asp) | css                                                    | width: 0px; height: 0px; |
| [lang](https://www.w3school.com.cn/tags/att_standard_lang.asp) | 规定元素内容的语言。                                   | 中文zh英文en             |
| [title](https://www.w3school.com.cn/tags/att_standard_title.asp) | 悬停显示的提示                                         |                          |
| [data-*](https://www.w3school.com.cn/tags/att_global_data.asp) 5 | 自定义数据                                             | data-flag=1              |
| [hidden](https://www.w3school.com.cn/tags/att_global_hidden.asp) 5 | 规定元素仍未或不再相关。                               |                          |
| [accesskey](https://www.w3school.com.cn/tags/att_standard_accesskey.asp) | 规定激活元素的快捷键。                                 |                          |
| [contenteditable](https://www.w3school.com.cn/tags/att_global_contenteditable.asp) 5 | 规定元素内容是否可编辑。                               |                          |
| [contextmenu](https://www.w3school.com.cn/tags/att_global_contextmenu.asp) 5 | 规定元素的上下文菜单。上下文菜单在用户点击元素时显示。 |                          |
| [dir](https://www.w3school.com.cn/tags/att_standard_dir.asp) | 规定元素中内容的文本方向。                             |                          |
| [draggable](https://www.w3school.com.cn/tags/att_global_draggable.asp) 5 | 规定元素是否可拖动。                                   |                          |
| [dropzone](https://www.w3school.com.cn/tags/att_global_dropzone.asp) 5 | 规定在拖动被拖动数据时是否进行复制、移动或链接。       |                          |
| [spellcheck](https://www.w3school.com.cn/tags/att_global_spellcheck.asp) 5 | 规定是否对元素进行拼写和语法检查。                     |                          |
| [tabindex](https://www.w3school.com.cn/tags/att_standard_tabindex.asp) | 规定元素的 tab 键次序。                                |                          |
| [translate](https://www.w3school.com.cn/tags/att_global_translate.asp) 5 | 规定是否应该翻译元素内容。                             |                          |



## doc-type

doc type 什么当前文档类型，与shell的#!/bin/bash相同。

>`<!DOCTYPE html>` 可以不写，浏览器也会默认

## html

| 标签 | 默认css                           | 描述 | 备注 |
| ---- | --------------------------------- | ---- | ---- |
| html | html {<br/> display: block;<br/>} |      |      |

### head

| 标签  | 默认css                           | 描述                                            | 备注 |
| ----- | --------------------------------- | ----------------------------------------------- | ---- |
| head  | head {<br/> display: none;<br/>}  |                                                 |      |
| title | title {<br/> display: none;<br/>} |                                                 |      |
| meta  | meta {<br/> display: none;<br/>}  | meta主要使用来做SEO的。<br/>SEO是指搜索引擎优化 |      |



### body

#### 框架性标签

##### 区块标签(div-header-section-footernav-aside-article)

| 标签                                                    | 默认css                          | 描述 | 备注 |
| ------------------------------------------------------- | -------------------------------- | ---- | ---- |
| div : header : section : footer : nav : aside : article | div {<br/> display: block;<br/>} |      |      |



##### 表格标签(table-tr-td)

| 标签  | 默认css                                                      | 描述         | 备注 |
| ----- | ------------------------------------------------------------ | ------------ | ---- |
| table | table {<br/> display: table;<br/> border-collapse: separate;<br/> box-sizing: border-box;<br/> border-spacing: 2px;<br/> border-color: grey;<br/>} |              |      |
| thead | thead {<br/> display: table-header-group;<br/> vertical-align: middle;<br/> border-color: inherit;<br/>} | 表的头部     | 可无 |
| tbody | tbody {<br/> display: table-row-group;<br/> vertical-align: middle;<br/> border-color: inherit;<br/>} | 表的主体     |      |
| tfoot | tfoot {<br/> display: table-footer-group;<br/> vertical-align: middle;<br/> border-color: inherit;<br/>} |              |      |
| th    | th {<br/> display: table-cell;<br/> vertical-align: inherit;<br/> font-weight: bold;<br/> text-align: -internal-center;<br/>} | 表头的单元格 |      |
| tr    | tr {<br/> display: table-row;<br/> vertical-align: inherit;<br/> border-color: inherit;<br/>} | 行           |      |
| td    | td {<br/> display: table-cell;<br/> vertical-align: inherit;<br/>} | 单元格       |      |

| 属性    | 功能           | 备注   |
| ------- | -------------- | ------ |
| border  | table的画表线  | table  |
| rowspan | 跨行(合并上下) | td标签 |
| colspan | 跨列(合并左右) | td标签 |



##### 列表标签(ol-ul-li和dl-dt-dd)

o-order         ol-li   有序列表

u-un             ul-li    无序列表

d-defined    dl-dd  自定义列表

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
|      | ol {<br/> display: block;<br/> list-style-type: decimal;<br/> margin-block-start: 1em;<br/> margin-block-end: 1em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> padding-inline-start: 40px;<br/>} |      |      |
|      | ul {<br/> display: block;<br/> list-style-type: disc;<br/> margin-block-start: 1em;<br/> margin-block-end: 1em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> padding-inline-start: 40px;<br/>} |      |      |
|      | li {<br/> display: list-item;<br/> text-align: -webkit-match-parent;<br/>} |      |      |
|      | dl {<br/> display: block;<br/> margin-block-start: 1em;<br/> margin-block-end: 1em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/>} |      |      |
|      | dt {<br/> display: block;<br/>}                              |      |      |
|      | dd {<br/> display: block;<br/> margin-inline-start: 40px;<br/>} |      |      |



##### 标题标签(h1)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
|      | h1 {<br/> display: block;<br/> font-size: 2em;<br/> margin-block-start: 0.67em;<br/> margin-block-end: 0.67em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> font-weight: bold;<br/>} |      |      |
|      | h2 {<br/> display: block;<br/> font-size: 1.5em;<br/> margin-block-start: 0.83em;<br/> margin-block-end: 0.83em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> font-weight: bold;<br/>} |      |      |
|      | h3 {<br/> display: block;<br/> font-size: 1.17em;<br/> margin-block-start: 1em;<br/> margin-block-end: 1em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> font-weight: bold;<br/>} |      |      |
|      | h4 {<br/> display: block;<br/> margin-block-start: 1.33em;<br/> margin-block-end: 1.33em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> font-weight: bold;<br/>} |      |      |
|      | h5 {<br/> display: block;<br/> font-size: 0.83em;<br/> margin-block-start: 1.67em;<br/> margin-block-end: 1.67em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> font-weight: bold;<br/>} |      |      |
|      | h6 {<br/> display: block;<br/> font-size: 0.67em;<br/> margin-block-start: 2.33em;<br/> margin-block-end: 2.33em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/> font-weight: bold;<br/>} |      |      |



##### 段落标签(p)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
|      | p {<br/> display: block;<br/> margin-block-start: 1em;<br/> margin-block-end: 1em;<br/> margin-inline-start: 0px;<br/> margin-inline-end: 0px;<br/>} |      |      |



##### 换行标签(br)

| 标签 | 默认css | 描述 | 备注 |
| ---- | ------- | ---- | ---- |
| br   | 无      |      |      |



##### 水平线标签(hr)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
|      | hr {<br/> display: block;<br/> unicode-bidi: isolate;<br/> margin-block-start: 0.5em;<br/> margin-block-end: 0.5em;<br/> margin-inline-start: auto;<br/> margin-inline-end: auto;<br/> overflow: hidden;<br/> border-style: inset;<br/> border-width: 1px;<br/>} |      |      |



#### 内容性标签

##### 字体样式标签

| 标签   | 默认css | 描述 | 备注 |
| ------ | ------- | ---- | ---- |
| i      |         | 斜体 |      |
| strong |         | 粗体 |      |





##### 链接(a)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
|      | a:-webkit-any-link {<br/> color: -webkit-link;<br/> cursor: pointer;<br/> text-decoration: underline;<br/>} |      |      |

| 属性   | 功能                     | 备注                                                         |
| ------ | ------------------------ | ------------------------------------------------------------ |
| href   | 打开的链接               |                                                              |
| target | 怎样的方式展示打开的页面 | \_self当前也页面(刷新)<br>\_blank新标签<br>\_parent<br>\_top<br>自定义 |

```html
<a href="http://www.baidu.com" target="iframe_name">在iframe中打开新窗口</a>
<iframe src="./html2.html" name="iframe_name" frameborder="0"></iframe>
```



##### 图像(img)

| 标签 | 默认css | 描述 | 备注 |
| ---- | ------- | ---- | ---- |
| img  | 无      |      |      |

| 属性   | 功能                 | 备注             |
| ------ | -------------------- | ---------------- |
| src    | 图片路径             |                  |
| alt    | 图片不存在时的提示语 |                  |
| width  | 图片的宽，自带px     |                  |
| height | 图片的高，自带px     | 50px或50都是50px |



##### 视频(vedio)

| 标签  | 默认css                                 | 描述 | 备注 |
| ----- | --------------------------------------- | ---- | ---- |
| vedio | video {<br/>
 object-fit: contain;<br/>
} |      |      |

| 属性     | 功能     | 备注               |
| -------- | -------- | ------------------ |
| controls | 显示控件 | 必须，不然播放不了 |
| autoplay |          |                    |



##### 音频(vedio)

| 标签  | 默认css                                             | 描述 | 备注 |
| ----- | --------------------------------------------------- | ---- | ---- |
| audio | audio {<br/>
 width: 300px;<br/>
 height: 54px;<br/>
} |      |      |

##### 表单

| 标签   | 默认css                                                      | 描述 | 备注 |
| ------ | ------------------------------------------------------------ | ---- | ---- |
| form   | form {<br/>
 display: block;<br/>
 margin-top: 0em;<br/>
}      |      |      |
| input  | input {<br/>
 -webkit-writing-mode: horizontal-tb !important;<br/>
 text-rendering: auto;<br/>
 color: -internal-light-dark(black, white);<br/>
 letter-spacing: normal;<br/>
 word-spacing: normal;<br/>
 text-transform: none;<br/>
 text-indent: 0px;<br/>
 text-shadow: none;<br/>
 display: inline-block;<br/>
 text-align: start;<br/>
 appearance: textfield;<br/>
 background-color: -internal-light-dark(rgb(255, 255, 255), rgb(59, 59, 59));<br/>
 -webkit-rtl-ordering: logical;<br/>
 cursor: text;<br/>
 margin: 0em;<br/>
 font: 400 13.3333px Arial;<br/>
 padding: 1px 2px;<br/>
 border-width: 2px;<br/>
 border-style: inset;<br/>
 border-color: -internal-light-dark(rgb(118, 118, 118), rgb(195, 195, 195));<br/>
 border-image: initial;
} |      |      |
| select | select {<br/>
 -webkit-writing-mode: horizontal-tb !important;<br/>
 text-rendering: auto;<br/>
 color: -internal-light-dark(black, white);<br/>
 letter-spacing: normal;<br/>
 word-spacing: normal;<br/>
 text-transform: none;<br/>
 text-indent: 0px;<br/>
 text-shadow: none;<br/>
 display: inline-block;<br/>
 text-align: start;<br/>
 appearance: menulist;<br/>
 box-sizing: border-box;<br/>
 align-items: center;<br/>
 white-space: pre;<br/>
 -webkit-rtl-ordering: logical;<br/>
 background-color: -internal-light-dark(rgb(255, 255, 255), rgb(59, 59, 59));<br/>
 cursor: default;<br/>
 margin: 0em;<br/>
 font: 400 13.3333px Arial;<br/>
 border-radius: 0px;<br/>
 border-width: 1px;<br/>
 border-style: solid;<br/>
 border-color: -internal-light-dark(rgb(118, 118, 118), rgb(195, 195, 195));<br/>
 border-image: initial;<br/>
} |      |      |
| option | option {<br/>
 font-weight: normal;<br/>
 display: block;<br/>
 white-space: pre;<br/>
 min-height: 1.2em;<br/>
 padding: 0px 2px 1px;<br/>
} |      |      |



### 内联嵌套(iframe)

| 标签   | 默认css                                                      | 描述 | 备注 |
| ------ | ------------------------------------------------------------ | ---- | ---- |
| iframe | iframe {<br/>
 border-width: 2px;<br/>
 border-style: inset;<br/>
 border-color: initial;<br/>
 border-image: initial;<br/>
} |      |      |

| 属性 | 功能 | 备注 |
| ---- | ---- | ---- |
|      |      |      |

