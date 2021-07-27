# 一、进制转化

## (一)、2/8/10/16进制间相互转化 base_convert

### 1、10与2

>```php
>/*
>10进制  0123456789
>2 进制  01
>*/
>/*
>10进制 905
>2 进制 1110001001
>*/
>```
>
>10进制转成2进制
>
>```php
>/*
>数字905
>
>905/2=452...1
>452/2=226...0
>226/2=113...0
>113/2=56....1
>56 /2=28....0
>28 /2=14....0
>14 /2=7.....0
>7  /2=3.....1
>3  /2=1.....1     //从下往上写就是2进制 
>*/
>
>
>class Tt{
>
>
>    const NO2  = "01";
>    const NO8  = "01234567";
>    const NO10 = "0123456789";
>    const NO16 = "0123456789ABCDEF";
>
>    /*
>    把10进制转化为任意的其他进制
>    */
>    static function from10ToX($number, $to){
>        $toArr = str_split($to);
>        $toLength = count($toArr);
>
>        $toNumber = '';
>        do{
>            $div = intval($number /$toLength);
>            $balance = $number % $toLength;
>            $toNumber = $toArr[$balance] . $toNumber;
>            //重新赋值，准备下一轮
>            $number = $div;
>        }while($number >= $toLength);
>        if($number > 0) $toNumber = $toArr[$number] . $toNumber;
>        return $toNumber;
>    }
>
>    static function fromXTo10($number, $from){
>        $fromArr = str_split($from);
>        $fromArrFlip = array_flip($fromArr);
>        $fromLength = count($fromArr);
>
>        $numberArr = str_split(strrev($number));//1101 转为 [1,0,1,1]
>
>        $to = 0;
>        foreach($numberArr as $step => $letter){
>            $to += ($fromArrFlip[$letter]) * pow($fromLength, $step);
>        }
>        return $to;
>    }
>
>    static function fromXToY($number, $from, $to){
>        if($from != self::NO10){
>            $number = self::fromXTo10($number, $from);
>        }
>        return self::from10ToX($number, $to);
>    }
>}
>
>var_dump(Tt::from10ToX(905, Tt::NO16));
>var_dump(Tt::fromXto10('1110001001', Tt::NO2));//905
>var_dump(Tt::fromXToY('1110001001', Tt::NO2, Tt::NO16));//389H/OX389
>var_dump(3*16*16+8*16+9);
>
>
>```
>
>2进制转成10进制
>
>```php
>/*
>数字1110001001
>9876543210
>1110001001
>1*2^9 + 1*2^8 + 1*2^7 + 1*2^3 + 1*2^0
>
>步骤：
>1、把二进制上所有的非0(二进制只有1)，从最右边第一位计0开始，计算位置步数；
>2、把[非0数字]*2^位置步数
>*/
>```
>
>

### 2、10与8

### 3、10与16

### 4、2与8

### 5、2与16

### 6、8与16

## (二)、任意进制间转化

## (三)、自定义进制间转化

> ```php
> /*
> 这是一个5进制 aU8od
> 这是一个7进制 AD9jukL
> 
> 
> */
> ```
>
> 

