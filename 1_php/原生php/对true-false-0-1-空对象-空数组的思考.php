<?php
$str1 = true;
$str2 = false;
$str3 = 'true';
$str4 = 'false';
$str5 = 1;
$str6 = 0;
$str7 = '1';
$str8 = '0';
$str9 = '';
$str10 = [];
$str11 = new stdClass();
//var_dump($str11);
echo "<xmp>a- $str1</xmp>";var_dump(!$str1); var_dump(empty($str1));//!true   =>false
echo "<xmp>a- $str2</xmp>";var_dump(!$str2); var_dump(empty($str2));//!false  =>true
echo "<xmp>a- $str3</xmp>";var_dump(!$str3); var_dump(empty($str3));//!'true' =>false
echo "<xmp>a- $str4</xmp>";var_dump(!$str4); var_dump(empty($str4));//!'false'=>false
echo "<xmp>a- $str5</xmp>";var_dump(!$str5); var_dump(empty($str5));//!1      =>false
echo "<xmp>a- $str6</xmp>";var_dump(!$str6); var_dump(empty($str6));//!0      =>true
echo "<xmp>a- $str7</xmp>";var_dump(!$str7); var_dump(empty($str7));//!'1'    =>false
echo "<xmp>a- $str8</xmp>";var_dump(!$str8); var_dump(empty($str8));//!'0'    =>true
echo "<xmp>a- $str9</xmp>";var_dump(!$str9); var_dump(empty($str9));//!''     =>true
echo "<xmp>a- []</xmp>";   var_dump(!$str10);var_dump(empty($str10));//![]    => true
echo "<xmp>a- {}</xmp>";   var_dump(!$str11);var_dump(empty($str11));//!{}    => false

echo "<hr/>";

var_dump($str2 == $str4);//'false' 不等于 false
var_dump($str2 == $str6);//true
var_dump($str2 == $str8);//true
var_dump($str2 == $str9);//true
var_dump($str2 == $str10);//true
var_dump($str2 == $str11);//空对象 不等于 false

echo "<hr />";

if($str1)  var_dump(true); else var_dump(false); //true   => true
if($str2)  var_dump(true); else var_dump(false); //false  =>false
if($str3)  var_dump(true); else var_dump(false); //'true' =>true
if($str4)  var_dump(true); else var_dump(false); //'false'=>true
if($str5)  var_dump(true); else var_dump(false); //1      =>true
if($str6)  var_dump(true); else var_dump(false); //0      =>false
if($str7)  var_dump(true); else var_dump(false); //'1'    =>true
if($str8)  var_dump(true); else var_dump(false); //'0'    =>false
if($str9)  var_dump(true); else var_dump(false); //''     =>false
if($str10) var_dump(true); else var_dump(false);//[]      =>false
if($str11) var_dump(true); else var_dump(false);//{}      =>true



