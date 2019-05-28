#!/bin/bash
# Invoked automatically (by init_session.php) after loading carlosvazquez.ddns.net

TIMEOUT=30;
sessionid=$1;
pid=$$;

# Schedule a cleanup of this session in TIMEOUT seconds
bash -c "sleep "${TIMEOUT}"; /var/www/scripts/webuser_cleanup.sh "${sessionid}" "${pid} &

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
