<?php
// Start a bash script implementing a simple Read Eval Print loop
shell_exec("nohup /var/www/html/loop.sh > /dev/null &");

// Wait for initialization message from loop.sh
//shell_exec("cat ");
?>
