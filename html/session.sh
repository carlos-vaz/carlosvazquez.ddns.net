#!/bin/bash
# Invoked automatically (by init_session.php) after loading carlosvazquez.ddns.net

sessionid=$1;

while true
do
	if read line </var/www/html/fifo/${sessionid}_tobash; then
		if [[ "$line" == 'quit' ]]; then
			break
		fi
		echo "Read: " $line > /var/www/html/fifo/${sessionid}_tophp
	fi
done
echo "Finished" > /var/www/html/fifo/${sessionid}_tophp
