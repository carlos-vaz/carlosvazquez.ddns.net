#!/bin/bash

#while true
#do
if read line </var/www/html/fifo_tobash; then
	if [[ "$line" == 'q' ]]; then
		break
	fi
	echo "Read: " $line > /var/www/html/fifo_tophp
fi
#done
#echo "Finished" > /var/www/html/fifo_tophp
