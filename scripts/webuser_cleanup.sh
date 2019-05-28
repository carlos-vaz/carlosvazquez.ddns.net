#!/bin/bash
# Executed by session.sh script on session timeout
# Cleans up session resources

session_id=$1;
session_pid=$2;

# Clean up your pipes
rm /var/www/html/fifo/${session_id}_tophp;
rm /var/www/html/fifo/${session_id}_tobash;

# Kill your session process
kill -TERM ${session_pid};
