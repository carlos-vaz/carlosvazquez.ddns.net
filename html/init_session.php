<?php
// First, assign a unique user ID to identify this sessions resources
// TODO: lock userlog file when creating user
$uid = substr("webuser-" . shell_exec("wc -l /var/www/security/userlog | awk -F ' ' '{print $1}'"), 0, -1);
$sessionid = md5($uid . shell_exec("cat /var/www/security/credentials") . exec("date +%s%N"));
shell_exec("echo " . $uid . " " . $sessionid . " >> /var/www/security/userlog");

// Respond to AJAX request
echo "<p id=\"dest_terminal\">Welcome, " . $uid . "!<br><span style=\"color:blue\">beast$</span> <input id=\"user_command\" type=\"text\" name=\"command\" style=\"display:inline-block;width:40%;\"></p>";
echo "<p id=\"dest_log\">" . $sessionid . "</p>";

// "Fork-and-forget" a new process that will create a secure session inside /var/www/jail/
shell_exec("nohup /var/www/scripts/enter_jail.sh " . $sessionid . " > /dev/null &");
?>
