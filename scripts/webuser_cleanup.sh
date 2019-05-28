#!/bin/bash
# Executed by www-data on session timeout
# Cleans up session resources

session_id=$1;
session_pid=$2;

# Clean up your pipes
rm /var/www/jail/fifo/${session_id}_tophp;
rm /var/www/jail/fifo/${session_id}_tobash;

# Kill your session process
kill -TERM ${session_pid};
