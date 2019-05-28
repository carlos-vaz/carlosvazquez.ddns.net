<?php
// Retrieve sessionid and bash command from new HTTP request
$requested_session = $_POST["sessionid"];
//$command = $_POST["cmd"];
$command = "harmless";

// Verify requested sessionid
if (!file_exists($requested_session . "_tophp") || !file_exists($requested_session . "_tobash")) {
	exit("The session you are trying to reach is old or invalid\n");
}

// Pass command request to session
shell_exec("echo " . $command . " > /var/www/html/fifo/" . $requested_session . "_tobash"); // blocks php until/unless session.sh has begun
echo exec("cat /var/www/html/fifo/" . $requested_session . "_tophp") . "\n"; // send output of bash back to the client
?>
