<?php
// First, assign a unique user ID to identify this sessions resources
// TODO: lock userlog file when creating user
$uid = substr("webuser-" . shell_exec("wc -l /var/www/security/userlog | awk -F ' ' '{print $1}'"), 0, -1);
$sessionid = md5($uid . shell_exec("cat /var/www/security/credentials"));
shell_exec("echo " . $uid . " " . $sessionid . " >> /var/www/security/userlog");

// Create named pipes, unique to this user, for passing commands to the session and outputs to php
shell_exec("mkfifo /var/www/fifo/" . $sessionid . "_tobash");
shell_exec("mkfifo /var/www/fifo/" . $sessionid . "_tophp");

// Respond to AJAX request
echo "<p id=\"dest_terminal\">Welcome, " . $uid . "!<br>beast$ </p>";
echo "<p id=\"dest_log\">" . $sessionid . "</p>";

// Start a bash script implementing a simple Read Eval Print loop
shell_exec("nohup /var/www/scripts/session.sh " . $sessionid . " > /dev/null &");
?>
