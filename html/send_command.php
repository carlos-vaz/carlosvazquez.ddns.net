<?php
// Retrieve sessionid and bash command from new HTTP request
$requested_session = $_POST["sessionid"];
$command = $_POST["cmd"];
//$command = "harmless";

// Verify requested sessionid
if (!file_exists("/var/www/fifo/" . $requested_session . "_tophp") || !file_exists("/var/www/fifo/" . $requested_session . "_tobash")) {
	exit("The session you are trying to reach has expired! Please reload the page. \n");
}

// Pass command request to session
shell_exec("echo " . $command . " > /var/www/fifo/" . $requested_session . "_tobash"); // blocks php until/unless session.sh has begun

// send output of bash back to the client
exec("cat /var/www/fifo/" . $requested_session . "_tophp", $OUTPUT);
foreach($OUTPUT as $line) {
	echo $line . "<br>";
}
echo "beast$ ";
?>
