#!/bin/bash
# Invoked automatically (by init_session.php --> enter_jail.sh --> here) after loading
# carlosvazquez.ddns.net. By the time this script is called, the new root / is actually
# /var/www/jail/ and all commands are run with root permission. This downgrades the 
# permission by setting the UID to 1001 (webuser)

sessionid=$1;

./switch_to_webuser ${sessionid};

