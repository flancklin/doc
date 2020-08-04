<?php
spl_autoload_register(function ($class){
    $classFile = strtr($class, ['flancklin\\'.basename(__DIR__).'\\' => __DIR__.DIRECTORY_SEPARATOR.'lib'.DIRECTORY_SEPARATOR]) . '.php';
    if(is_file($classFile)){
        include_once $classFile;
    }
});
