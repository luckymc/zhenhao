<?php
require_once('../lib/MySmarty.php');

$smarty = new MySmarty();
$smarty->assign('world', '����');
$smarty->assign('name', '�߳���');

$smarty->display('test.tpl');
?>