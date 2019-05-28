#!/bin/bash
#
# Invoked automatically (by init_session.php) after loading carlosvazquez.ddns.net.
# Schedules a session cleanup at timeout, creates pipes for communication between the bash
# session in jail/ and the apache-launched php scripts, changes its root to /var/www/jail/, and
# begins execution of the session there.
#
# This script has the SUID (set user id) permission bit set, which means when user www-data
# calls it, it will run with root privileges. Root privileges are necessary in order for
# this script to be allowed to change the root directory to jail/

TIMEOUT=300;	# Timeout after 5 minutes
sessionid=$1;
pid=$$;

# Schedule a cleanup of this session in TIMEOUT seconds
bash -c "sleep "${TIMEOUT}"; /var/www/scripts/webuser_cleanup.sh "${sessionid}" "${pid} &

# Create named pipes for communication with the session
mkfifo /var/www/jail/fifo/${sessionid}_tophp;
mkfifo /var/www/jail/fifo/${sessionid}_tobash;

# Send this process to jail and begin its session there (won't return)
/var/www/scripts/start_session_in_jail ${sessionid};
