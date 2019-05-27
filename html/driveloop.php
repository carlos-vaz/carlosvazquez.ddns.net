<?php
//$command=$_POST["cmd"];
$command="payload";
echo "just echoing " . $command;
shell_exec("/var/www/html/loop.sh > /dev/null &");
shell_exec("echo " . $command . " > /var/www/html/fifo_tobash &"); // will block php
echo exec("cat /var/www/html/fifo_tophp") . "\n";
?>
