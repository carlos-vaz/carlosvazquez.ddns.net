#!/bin/bash
# Invoked automatically after loading carlosvazquez.ddns.net

# First, asign a unique user ID and store in ../security/userlog
uid="webuser-"$(wc -l ../security/userlog | awk -F " " '{print $1}')
echo $uid >> ../security/userlog

# Create named pipes, unique to this user, for passing commands to bash and outputs to php
mkfifo ./fifo/${uid}_tobash
mkfifo ./fifo/${uid}_tophp

# Send welcome messgae to init_session.php, who is waiting


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
