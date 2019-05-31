<?php
// Retrieve sessionid and bash command from new HTTP request
$requested_session = $_POST["sessionid"];
$command = $_POST["cmd"];
//$command = "harmless";

// Verify requested sessionid
if (!file_exists("/var/www/jail/fifo/" . $requested_session . "_tophp") || !file_exists("/var/www/jail/fifo/" . $requested_session . "_tobash")) {
	exit("The session you are trying to reach has expired! Please reload the page. \n");
}

// Pass command request to session
$fifo = fopen("/var/www/jail/fifo/" . $requested_session . "_tobash", "w"); // blocks until/unless reading fifo has begun
fwrite($fifo, $command . "\n");
fclose($fifo);

//shell_exec("echo " . $command . " > /var/www/jail/fifo/" . $requested_session . "_tobash");

// send output of bash back to the client
exec("cat /var/www/jail/fifo/" . $requested_session . "_tophp", $OUTPUT);
foreach($OUTPUT as $line) {
	echo $line . "<br>";
}
echo "<span style=\"color:blue\">beast$</span> <input id=\"user_command\" type=\"text\" name=\"command\" style=\"display:inline-block;width:40%;\">";

?>
