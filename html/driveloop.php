<?php
//$command=$_POST["cmd"];
$command="payload";
echo "just echoing " . $command;
//shell_exec("/var/www/html/loop.sh > /dev/null &");
shell_exec("echo " . $command . " > /var/www/html/fifo/fifo_tobash &"); // blocks php until/unless loop.sh is begun
echo exec("cat /var/www/html/fifo/fifo_tophp") . "\n";
?>
