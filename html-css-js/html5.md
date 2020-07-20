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

| 标签 | 默认css                 | 描述 | 备注 |
| ---- | ----------------------- | ---- | ---- |
| html | html {
 display: block;
} |      |      |

### head

| 标签  | 默认css                 | 描述                                           | 备注 |
| ----- | ----------------------- | ---------------------------------------------- | ---- |
| head  | head {
 display: none;
}  |                                                |      |
| title | title {
 display: none;
} |                                                |      |
| meta  | meta {
 display: none;
}  | meta主要使用来做SEO的。<br>SEO是指搜索引擎优化 |      |



### body

#### 框架性标签

##### 区块标签(div)

| 标签 | 默认css                | 描述 | 备注 |
| ---- | ---------------------- | ---- | ---- |
| div  | div {
 display: block;
} |      |      |

##### 表格标签(table-tr-td)

| 标签  | 默认css                                                      | 描述         | 备注 |
| ----- | ------------------------------------------------------------ | ------------ | ---- |
| table | table {
 display: table;
 border-collapse: separate;
 box-sizing: border-box;
 border-spacing: 2px;
 border-color: grey;
} |              |      |
| thead | thead {
 display: table-header-group;
 vertical-align: middle;
 border-color: inherit;
} | 表的头部     | 可无 |
| tbody | tbody {
 display: table-row-group;
 vertical-align: middle;
 border-color: inherit;
} | 表的主体     |      |
| tfoot | tfoot {
 display: table-footer-group;
 vertical-align: middle;
 border-color: inherit;
} | 表的结尾     |      |
| th    | th {
 display: table-cell;
 vertical-align: inherit;
 font-weight: bold;
 text-align: -internal-center;
} | 表头的单元格 |      |
| tr    | tr {
 display: table-row;
 vertical-align: inherit;
 border-color: inherit;
} | 行           |      |
| td    | td {
 display: table-cell;
 vertical-align: inherit;
}          | 单元格       |      |

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
| ol   | ol {
 display: block;
 list-style-type: decimal;
 margin-block-start: 1em;
 margin-block-end: 1em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 padding-inline-start: 40px;
} |      |      |
| ul   | ul {
 display: block;
 list-style-type: disc;
 margin-block-start: 1em;
 margin-block-end: 1em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 padding-inline-start: 40px;
} |      |      |
| li   | li {
 display: list-item;
 text-align: -webkit-match-parent;
}  |      |      |
| dl   | dl {
 display: block;
 margin-block-start: 1em;
 margin-block-end: 1em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
} |      |      |
| dt   | dt {
 display: block;
}                                        |      |      |
| dd   | dd {
 display: block;
 margin-inline-start: 40px;
}             |      |      |



##### 标题标签(h1)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
| h1   | h1 {
 display: block;
 font-size: 2em;
 margin-block-start: 0.67em;
 margin-block-end: 0.67em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 font-weight: bold;
} |      | 最大 |
| h2   | h2 {
 display: block;
 font-size: 1.5em;
 margin-block-start: 0.83em;
 margin-block-end: 0.83em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 font-weight: bold;
} |      |      |
| h3   | h3 {
 display: block;
 font-size: 1.17em;
 margin-block-start: 1em;
 margin-block-end: 1em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 font-weight: bold;
} |      |      |
| h4   | h4 {
 display: block;
 margin-block-start: 1.33em;
 margin-block-end: 1.33em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 font-weight: bold;
} |      |      |
| h5   | h5 {
 display: block;
 font-size: 0.83em;
 margin-block-start: 1.67em;
 margin-block-end: 1.67em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 font-weight: bold;
} |      |      |
| h6   | h6 {
 display: block;
 font-size: 0.67em;
 margin-block-start: 2.33em;
 margin-block-end: 2.33em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
 font-weight: bold;
} |      | 最小 |



##### 段落标签(p)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
| p    | p {
 display: block;
 margin-block-start: 1em;
 margin-block-end: 1em;
 margin-inline-start: 0px;
 margin-inline-end: 0px;
} |      |      |



##### 换行标签(br)

| 标签 | 默认css | 描述 | 备注 |
| ---- | ------- | ---- | ---- |
| br   | 无      |      |      |



##### 水平线标签(hr)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
| hr   | hr {
 display: block;
 unicode-bidi: isolate;
 margin-block-start: 0.5em;
 margin-block-end: 0.5em;
 margin-inline-start: auto;
 margin-inline-end: auto;
 overflow: hidden;
 border-style: inset;
 border-width: 1px;
} |      |      |



#### 内容性标签

##### 字体样式标签

| 标签   | 默认css | 描述 | 备注 |
| ------ | ------- | ---- | ---- |
| i      |         | 斜体 |      |
| strong |         | 粗体 |      |

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



音频

链接(a)

| 标签 | 默认css                                                      | 描述 | 备注 |
| ---- | ------------------------------------------------------------ | ---- | ---- |
| a    | a:-webkit-any-link {
 color: -webkit-link;
 cursor: pointer;
 text-decoration: underline;
} |      |      |

| 属性   | 功能                     | 备注                                                         |
| ------ | ------------------------ | ------------------------------------------------------------ |
| href   | 打开的链接               |                                                              |
| target | 怎样的方式展示打开的页面 | \_self当前也页面(刷新)<br>\_blank新标签<br>\_parent<br>\_top |



