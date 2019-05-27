#!/bin/bash
# Invoked automatically after loading carlosvazquez.ddns.net

while true
do
	if read line </var/www/html/fifo/${uid}_tobash; then
		if [[ "$line" == 'q' ]]; then
			break
		fi
		echo "Read: " $line > /var/www/html/fifo/${uid}_tophp
	fi
done
echo "Finished" > /var/www/html/fifo/${uid}_tophp
