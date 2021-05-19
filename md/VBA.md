# 一、入门须知

## (一)、hello world

>* 在Excel中按下alt+F11，可以打开宏编辑界面：
>
>* 输入代码，关闭宏编辑界面：
>
> * ```vb
>   Sub hh()
>       MsgBox "hello world"
>   End Sub
>   ```
>
>* 回到Excel中，按下Alt+F8打开宏窗口，选择要执行的宏，点击执行：
>
>* 宏代码执行结果.[会有一个弹框‘sssssssssssss’]



## (二)、文档文献

>**官方**
>
>* 在线中文https://docs.microsoft.com/zh-cn/office/vba/api/overview/language-reference
>* 在线英文https://docs.microsoft.com/en-us/office/vba/api/overview/language-reference

## (三)、注释

>左单引号 ，
>
>* ***只有左半边哦***
>* ***而且是英文状态得单引号***
>
>```vb
>'我是注释
>```

## (四)、转义字符

## (五)、调试

逐行调试

>
>
>* 光标停留在需要执行得代码块中(只要在块中就行)
>* 按一次F8执行一行。

# 二、语法

## (一)、数据类型

## (二)、变量和常量

## (三)、运算符

### 1、赋值运算符

>| 序号 | 符号 | 作用 | 举例 | 备注 |
>| ---- | ---- | ---- | ---- | ---- |
>| 1    | =    | 赋值 |      |      |
>

### 2、算术运算符

>| 序号 | 符号   | 作用       | 举例 | 备注 |
>| ---- | ------ | ---------- | ---- | ---- |
>| 1    | +      | 加法       |      |      |
>| 2    | -      | 减法       |      |      |
>| 3    | *      | 乘法       |      |      |
>| 4    | /      | 除法       |      |      |
>|      |        |            |      |      |
>| 5    | -      | 取反(负号) |      |      |
>| 6    | Mod    | 取模(求余) |      |      |
>| 7    | ^      | 指数(求幂) |      |      |
>|      |        |            |      |      |
>| 8    | \      | 整除       |      |      |
>| 9    | 不支持 | 递增       |      |      |
>| 10   | 不支持 | 递减       |      |      |

>

### 3、逻辑运算符

>| 序号 | 符号 | 作用 | 举例 | 备注 |
>| ---- | ---- | ---- | ---- | ---- |
>| 1    | Not  | 非   |      |      |
>| 2    | And  | 与   |      |      |
>| 3    | Or   | 或   |      |      |
>| 4    | Xor  | 异或 |      |      |
>|      |      |      |      |      |
>| 5    | Eqv  | 相等 |      |      |
>| 6    | Imp  | 隐含 |      |      |

### 4、比较运算符(关系)

>| 序号 | 符号 | 作用     | 举例 | 备注 |
>| ---- | ---- | -------- | ---- | ---- |
>|      | >    | 大于     |      |      |
>|      | <    | 小于     |      |      |
>|      | >=   | 大于等于 |      |      |
>|      | <=   | 小于等于 |      |      |
>|      | =    | 等于     |      |      |
>|      | <>   | 不等于   |      |      |
>|      |      |          |      |      |

### 5、字符串运算符

### 6、位运算符

### 7、数组运算符

### 8、其他

## (四)、流程控制

### 1、循环

#### (1)、do...loop

>Do [{While | Until} 表达式]
> [执行的一条或多条语句]
> [Exit Do]
> [[执行的一条或多条语句]
>
>Loop 
>
>或者可以使用下面这种语法：
>
>Do
> [执行的一条或多条语句]
> [Exit Do]
> [执行的一条或多条语句]
>
>Loop [{While | Until}表达式]
>
>----------------------------------------------------------------------------------
>
>* **while**：当这个条件为True时就循环
>
>  **until**：直到这个条件为True时就跳出循环
>
>* **Exit Do**:跳出当前do流程控制。只会跳出一层
>
>* **Exit Sub**:
>
> |      | A    | B    | C    |
> | ---- | ---- | ---- | ---- |
> | 1    | 姓名 | 成绩 | 等级 |
> | 2    | A1   | 91   | √    |
> | 3    | A2   | 54   |      |
> | 4    | A3   | 74   |      |
> | 5    | A4   | 50   |      |
> | 6    | A5   | 90   | √    |
> | 7    | A6   | 51   |      |
> | 8    | A7   | 84   |      |
> | 9    | A8   | 61   |      |
> | 10   | A9   | 98   | √    |
> |      |      |      |      |
>
>```vb
>Sub 基本示例()
>Dim rs%
>rs = 1
>Do
> rs = rs + 1
>    If rs > 10 Then
>        Exit Sub
>    Else
>        If Cells(rs, 2) >= 90 Then Cells(rs, 3) = "√"
>    End If
>Loop
>End Sub
>```
>
> 
>
>```vb
>Sub 循环语句while()
>Dim rs As Integer
>rs = 2
>Do While Cells(rs, 2) <> ""   '当单元格不等于空时，则循环
>    If Cells(rs, 2) >= 90 Then Cells(rs, 3) = "√"
>    rs = rs + 1
>Loop '循环
>End Sub
>```
>
> 
>
>```vb
>Sub 循环语句DOLOOP2()
>Dim rs As Integer
>rs = 2
>Do Until Cells(rs, 2) = "" '直到单元格为空为止，才结束
>    If Cells(rs, 2) >= 90 Then Cells(rs, 3) = "√"
>    rs = rs + 1
>Loop '循环
>```
>
>

#### (2)、for each ...next

>
>
> 
>
>* **Exit For**:跳出当前for流程控制。只会跳出一层
>
>|      | A    | B    |
>| ---- | ---- | ---- |
>| 1    | 品名 |      |
>| 2    | A1   |      |
>| 3    | A2   |      |
>| 4    | A1   |      |
>| 5    | A2   |      |
>
>把A列中a1设为红色背景
>
>```vb
>Sub foreachnext循环1()
>Dim rng As Range, n!
>For Each rng In Sheet1.Range("a2:a10") '取a2:a10中的每个单元格
>   If rng = "A1" Then rng.Interior.ColorIndex = 3
>Next
>End Sub
>```
>
>

#### (3)、for ...next

>
>
>* **Exit For**:跳出当前for流程控制。只会跳出一层
>* for A=1 to 10    A变量得取值范围【1,10】,是闭合区间
>* for ... to ...step...next
>
>```vb
>Sub testfor()
>Dim I%
>Dim J%
>Dim K%
>
>For I = 1 To 10
>    For J = 1 To 10
>        For K = 1 To 10
>        MsgBox I & J & K
>        Next K
>    Next J
>Next I
>
>End Sub
>```
>
>
>
>```vb
>Sub fornext循环2()
>Dim i!
>For i = 10 To 1 Step -2
>MsgBox i
>Next
>End Sub
>```
>
>



### 2、条件判断

#### (1)、if

>##### 单行形式(if ... then)
>
>>```vb
>>Sub test()
>>If A > 10 Then A = A + 1 : B = B + A : C = C + B
>>End Sub
>>    
>>'if(A>10) A = A + 1 : B = B + A : C = C + B
>>```
>>
>>*  A = A + 1 : B = B + A : C = C + B
>>  * 这是三个语句。在同一行中，多条语句需要使用冒号分开
>>
>>
>
>##### 单行形式(if ... then ... else ... )
>
>>```vb
>>Sub test()
>>If 2 > 1 Then MsgBox "yes" Else MsgBox "no"
>>End Sub
>>
>>'if(2>1){ MsgBox "yes";} else { MsgBox "no";}
>>```
>
>##### 块形式(if ... then ... end if)
>
>>```vb
>>If A > 10 Then 
>>A = A + 1
>>B = B + A 
>>C = C + B
>>End If
>>```
>
>##### 块形式嵌套(if...then...elseif...else...end if)
>
>>```vb
>>If Sheet1.Range("b1") >= 90 Then
>>    Sheet1.Range("b2") = "优"
>>ElseIf Sheet1.Range("b1") >= 80 Then
>>    Sheet1.Range("b2") = "良"
>>ElseIf Sheet1.Range("b1") >= 70 Then
>>    Sheet1.Range("b2") = "中"
>>Else
>>    Sheet1.Range("b2") = "差"
>>End If
>>```

#### (2)、select(switch)

>```vb
>Sub test-select()
>    Select Case Sheet1.[d1].Value
>    Case "A"
>    Sheet1.[a3] = "A型血的你，是个不怎么样的人！"
>    Case "B"
>    Sheet1.[a3] = "B型血的你，也是个不怎么样的人~"
>    Case "AB"
>    Sheet1.[a3] = "AB型血的你，是个更不怎么样的人~"
>    Case "O"
>    Sheet1.[a3] = "O型血的你，还是不错的！"
>    Case Else
>    Sheet1.[a3] = "没有这种型血，看来你 是个最不怎么样的人~！"
>    End Select
>End Sub
>```
>
>

### 3、跳转

#### (1)、GoTo

>
>
>* 格式：GoTo [行号|标签]
>
>```vb
>Sub gotoline()
>Dim str$
>line:
>str = InputBox("请录入用户名！")
>If str <> "admin" Then GoTo line
>End Sub
>```
>
>

#### (2)、GoSub...Return

>* 格式：GoSub 
>
>
>
>```vb
>'go to...return
>Sub gotoreturn()
>Dim i!
>For i = 2 To 10
>    If Sheet1.Range("a" & i) Mod 2 = 0 Then GoSub 100
>Next i
>Exit Sub
>100:
>        Sheet1.Range("b" & i) = "迟到"
> Return
>End Sub
>```
>
>| 上班打卡时间 | 考勤 |
>| ------------ | ---- |
>| 1            |      |
>| 2            | 迟到 |
>| 3            |      |
>| 4            | 迟到 |
>| 5            |      |
>| 6            | 迟到 |
>| 7            |      |
>| 8            | 迟到 |
>| 9            |      |

### 4、流程控制中断(exit|end)

>|                | exit   | end    |
>| -------------- | ------ | ------ |
>| do             | 支持   | 不支持 |
>| for            | 支持   | 不支持 |
>| if             | 不支持 | 支持   |
>| select(switch) | 不支持 | 支持   |
>| function       | 支持   | 支持   |
>| sub            | 支持   | 支持   |
>| 单独使用       | 不支持 | 支持   |
>
>* exit针对循环和块（跳出循环）
>* end针对判断和块（结束流程）

### 5、异常

### 6、引入文件

### 7、其他

#### (1)、with

>* with 语句 ,当对某个对象执行一系列的语句时，不用重复指出对象的名称。
>
>```vb
>'平时写法
>Sub with语句1()
>    a = Range("a1").Address
>    b = Range("a1").Parent.Name
>    Range("a1") = "1234"
>End Sub
>
>'with写法
>Sub with语句2()
>With Range("a1")
>    a = .Address
>    b = .Parent.Name
>    .Value = "1234"
>End With
>End Sub
>
>```
>
> 
>
>```vb
>'平时写法
>Sub with嵌套1()
>Range("a1").Value = "Who am i ?"
>Range("a1").Parent.Name = "Hello World"
>Range("a1").Font.Size = 20
>Range("a1").Font.Bold = True
>End Sub
>
>'with写法
>Sub with嵌套2()
>With Range("a1")
>    .Value = "Who am i ?"
>    .Parent.Name = "Hello World"
>    With .Font
>        .Size = 20
>        .Bold = True
>    End With
>End With
>End Sub
>
>```
>
>

## (五)、function

## (六)、对象

## (七)、进程性指令

## (八)、错误与异常(on error)

>
>
>* 格式： On Error { GoTo [ line | 0 | -1 ] | Resume Next }
>
>```vb
>Sub onerrorresume()
>Dim i!
>On Error Resume Next '当错误的时候继续执行下去
>For i = 2 To 8
>    Cells(i, 4) = Cells(i, 3) + Cells(i, 2)
>Next i
>End Sub
>
>'------------------------------------------------------
>
>'On Error GoTo当错误的时候去哪儿?
>Sub onerrorgoto()
>On Error GoTo 100
>For i = 2 To 8
>    k = Sheet1.Cells(i, 2) + Sheet1.Cells(i, 3)
>Next i
>100:
>   MsgBox "对不起，错误发生在第" & i & "行"
>End Sub
>```
>
>

# 三、预定义

## (一)、变量

## (二)、常量

(三)、

# 开发环境【visual basic】和【宏】

>
>
>1. 在 **“文件”** 选项卡上，选择 **“选项”** 以打开 **“选项”** 对话框。
>2. 选择该对话框左侧的 **“自定义功能区”**。
>3. 在该对话框左侧的 **“从下列位置选择命令”** 下，选择 **“常用命令”**。
>4. 在该对话框右侧的 **“自定义功能区”** 下，从下拉列表框中选择 **“主选项卡”**，然后选中 **“开发工具”** 复选框。
>5. 选择“**确定**”。
>6. 启用 **“开发工具”** 选项卡后，可以轻松找到 **“Visual Basic”** 和 **“宏”** 按钮。

# 对象模型

## 方法

>```vb
>Application.ActiveDocument.Save
>Application.ActiveDocument.SaveAs ("New Document Name.docx")
>```

## 属性

>
>
>```vb
>	Application.ActiveSheet.Range("A1").Select
>    Application.Selection.Value = "Hello World"
>```
>
>选择 Excel 中的单元格 A1，
>
>然后设置属性以在该单元格中放置内容
>
> 
>
>VBA 编程的第一个挑战是了解每个 Office 应用程序的对象模型以及阅读对象、方法和属性语法。 对象模型在所有 Office 应用程序中都类似，但每个对象模型都特定于它所操控的文档和对象的种类。
>
>代码段的第一行中有 **Application** 对象（这次是 Excel），然后是 **ActiveSheet**，它提供对活动工作表的访问。 在这之后，是不太熟悉的术语“Range”，它表示“用此方法定义单元格的范围。” 代码指示 **Range** 自行创建，并且只将 A1 作为其定义的一组单元格。 也就是说，代码的第一行定义对象“Range”，并对其运行方法以选择它。 结果会自动存储在名为 **Selection** 的 **Application** 的另一个属性中。
>
>代码的第二行将 **Selection** 的 **Value** 属性设置为文本“Hello World”，并且该值出现在单元格 A1 中。
>
>你编写的最简单的 VBA 代码可能只是获取对 Office 应用程序中你要处理的对象的访问权限并设置属性。 例如，你可以在 VBA 脚本中获取对 Word 中表中各行的访问权限并更改其格式。
>
>这听起来简单，但可能非常有用；一旦编写了代码，你就可以利用编程的所有强大功能在多个表或文档中进行相同更改，或者依据某种逻辑或条件来进行更改。 对于计算机而言，进行 1000 项更改与进行 10 项更改并无不同，因此这里对于较大的文档和问题而言就有了规模效应，而这正是 VBA 能够真正出彩和节省时间的原因。

# 声明变量Dim

>
>
>若要在 VBA 中使用变量，必须使用 **Dim** 语句告诉 VBA 变量所代表的对象类型。 然后，设置其值并用它来设置其他变量或属性。
>
>```vb
>	Dim MyStringVariable As String
>    MyStringVariable = "Wow!"
>    Worksheets(1).Range("A1").Value = MyStringVariable
>```

# 分支与循环

>
>
>```vb
>Sub Macro1()
>    If Worksheets(1).Range("A1").Value = "Yes!" Then
>        Dim i As Integer
>        For i = 2 To 10
>            Worksheets(1).Range("A" & i).Value = "OK! " & i
>        Next i
>    Else
>        MsgBox "Put Yes! in cell A1"
>    End If
>End Sub
>```





# 示例

## 求和

>```vb
>Sub iSum()
>   Dim c As Range, s
>    s = 0
>   For Each c In Range("A1:A5")
>       If IsNumeric(c) Then s = s + c
>   Next
>   Range("B2") = s
>End Sub
>```

## 取值与赋值

> 根据b1得分数，在b2显示优良中差
>
> ```vb
> Sub testa()
>     Dim score%, res
>     score = Sheet1.Range("b1")
>     If score >= 90 Then
>         res = "优秀"
>     ElseIf score >= 80 Then
>         res = "良好"
>     ElseIf score >= 70 Then
>         res = "中等"
>     Else
>         res = "较差"
>     End If
>     Sheet1.Range("b2") = res
> End Sub
> ```
>
> 

## 乘法口诀表

>
>
>```vb
>
>Sub 九九乘法表制作()
>Dim a!, b!
>For a = 1 To 9
>    For b = 1 To 9
>        If b > a Then
>            Sheet2.Cells(a, b) = ""
>         Else
>            Sheet2.Cells(a, b) = a & "×" & b & "=" & a * b
>        End If
>    Next
>Next
>End Sub
>
>```
>
>



## 输入公式

>
>
>```vb
>'在VBA中也可以像在工作中一样录入公式
>Sub VBA中的做法()
>Dim i%
>For i = 1 To 10
>    Range("c" & i) = Range("a" & i) + Range("b" & i)
>Next
>End Sub
>'-------------------------------------------------------------------------
>
>Sub 普通公式()
>Sheet1.Cells(1, 3) = "=a1+b1"
>End Sub
>'-------------------------------------------------------------------------
>
>Sub 批量计算()
>Dim i As Integer
>For i = 1 To 10
>    Sheet1.Cells(i, 4) = "=a" & i & "+b" & i
>Next i
>End Sub
>'-------------------------------------------------------------------------
>
>Sub 数组公式()
>Range("e1:e10").FormulaArray = "=a1:a10+b1:b10"
>End Sub
>'-------------------------------------------------------------------------
>Sub 带工作表函数的计算()
>Dim i As Integer
>For i = 1 To 10
>    Sheet1.Cells(i, 4) = "=sum(a" & i & ":b" & i & ")"
>Next i
>End Sub
>'-------------------------------------------------------------------------
>Sub 公式带引号的计算()
>Cells(12, 1) = "=COUNTIF(A1:A10,"">9"")"
>Cells(12, 2) = "=sum(INDIRECT(""a1:a10""))"
>End Sub
>'-------------------------------------------------------------------------
>'借用工作表函数
>Sub 运用工作表函数()
>MsgBox Application.WorksheetFunction.CountIf(range("a1:a10"), "钢笔")
>MsgBox WorksheetFunction.CountIf(range("a1:a10"), "钢笔")
>MsgBox Application.CountIf(range("a1:a10"), "钢笔")
>End Sub
>'-------------------------------------------------------------------------
>'VBA函数
>Sub VBA函数()
>MsgBox VBA.Format(range("b1"), "yyyy年m月d日")
>MsgBox Format(range("b1"), "yyyy年m月d日")
>End Sub
>'-------------------------------------------------------------------------
>'-------------------------------------------------------------------------
>'-------------------------------------------------------------------------
>'-------------------------------------------------------------------------
>
>```



## 自定义函数

>
>
>```vb
>
>'自定义函数
>Function SEX(rng As range)
>SEX = IIf(Mid(rng, 15, 3) Mod 2, "男", "女")
>End Function
>```
>
>|      | A                  | B    | 备注(B)  |
>| ---- | ------------------ | ---- | -------- |
>| 1    | 510322198711021243 | 女   | =SEX(A1) |
>| 2    | 510322198711021223 | 女   | =SEX(A2) |
>| 3    | 510322198711021213 | 男   | =SEX(A3) |
>| 4    | 510322198711021273 | 男   | =SEX(A4) |
>| 5    | 510322198711021263 | 女   | =SEX(A5) |

