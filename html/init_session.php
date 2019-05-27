<?php
// First, assign a unique user ID to identify this sessions resources
// TODO: lock userlog file when creating user
$uid = substr("webuser-" . shell_exec("wc -l /var/www/security/userlog | awk -F ' ' '{print $1}'"), 0, -1);
$sessionid = md5($uid . shell_exec("cat /var/www/security/credentials"));
shell_exec("echo " . $uid . " " . $sessionid . " >> /var/www/security/userlog");

// Create named pipes, unique to this user, for passing commands to the session and outputs to php
shell_exec("mkfifo /var/www/html/fifo/" . $uid . "_tobash");
shell_exec("mkfifo /var/www/html/fifo/" . $uid . "_tophp");

// Respond to AJAX request
echo "Welcome, " . $uid . "!<br>";

// Start a bash script implementing a simple Read Eval Print loop
shell_exec("nohup /var/www/html/loop.sh > /dev/null &");
?>
