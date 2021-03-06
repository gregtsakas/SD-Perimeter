#!/bin/bash

. /opt/sdp/scripts/config.sh

##insert data disconnected to table log
mysql -h$HOST -P$PORT -u$USER -p$PASS $DB -e "UPDATE log SET log_end_time=now(),log_received='$bytes_received',log_send='$bytes_sent' WHERE log_trusted_ip='$trusted_ip' AND log_trusted_port='$trusted_port' AND user_id='$common_name' AND log_end_time='0000-00-00 00:00:00'"
mysql -h$HOST -P$PORT -u$USER -p$PASS $DB -e "UPDATE user SET user_online='no' WHERE user_mail='$common_name' AND user_mail not in (select user_id from log where log_end_time='0000-00-00 00:00:00')"
