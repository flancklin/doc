<?php

$project = $_GET['p'] ?? '';
switch($project){
	case 'session':	
		include_once  "./flancklin/session/autoload.php";
		$o = new \flancklin\session\SessionHelper(new \flancklin\session\SessionHandlerMySql());
		var_dump($o->set("key","94444999"));
		var_dump($o->get("key"));
		break;
	default:
		var_dump("错误得项目");
}
