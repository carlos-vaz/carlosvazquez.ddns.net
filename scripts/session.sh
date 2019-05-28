#!/bin/bash
# Invoked automatically (by init_session.php) after loading carlosvazquez.ddns.net

#TIMEOUT=600;	# timeout after 10 minutes

sessionid=$1;

# Schedule a cleanup of this session in TIMEOUT seconds
#echo "/var/www/scripts/cleanup.sh "$sessionid | at now + 30 seconds;

while true
do
	if read line </var/www/html/fifo/${sessionid}_tobash; then
		if [[ "$line" == 'quit' ]]; then
			break
		fi
		${line} &> /var/www/html/fifo/${sessionid}_tophp
	fi
done
echo "Finished" > /var/www/html/fifo/${sessionid}_tophp
