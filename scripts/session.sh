#!/bin/bash
#
# Invoked automatically (by init_session.php) after loading carlosvazquez.ddns.net
# Schedules a session cleanup at timeout, puts itsels in a jail (with low permissions), and
# starts a session as a simple read-eval-print loop.
#
# This script has the SUID (set user id) permission bit set, which means when user www-data
# calls it, it will run with root priviledges. Root priviledges are necessary in order for
# this script to be allowed to change the root directory to jail/

TIMEOUT=300;	# Timeout after 5 minutes
sessionid=$1;
pid=$$;

# Schedule a cleanup of this session in TIMEOUT seconds
bash -c "sleep "${TIMEOUT}"; /var/www/scripts/webuser_cleanup.sh "${sessionid}" "${pid} &

# Change user (currently www-data), & change root directory to /var/www/jail
chroot /var/www/jail /bin/bash;

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
