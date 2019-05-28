#!/bin/bash
# Invoked automatically (by init_session.php) after loading carlosvazquez.ddns.net

TIMEOUT=300;	# Timeout after 5 minutes
sessionid=$1;
pid=$$;

# Schedule a cleanup of this session in TIMEOUT seconds
bash -c "sleep "${TIMEOUT}"; /var/www/scripts/webuser_cleanup.sh "${sessionid}" "${pid} &

while true
do
	if read line </var/www/fifo/${sessionid}_tobash; then
		if [[ "$line" == 'quit' ]]; then
			break
		fi
		#echo ${line} "&> fifo" > /var/www/fifo/${sessionid}_tophp
		${line} &> /var/www/fifo/${sessionid}_tophp
	fi
done
echo "Finished" > /var/www/fifo/${sessionid}_tophp
