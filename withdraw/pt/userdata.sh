#!/bin/bash

exec 2> /var/log/user-data.log # send stderr to a log file
exec 1>&2  # send stdout to the same log file
set -x   # tell sh to display commands before execution

sudo sed -i s/STACK_ID/stack_id/g /etc/telegraf/telegraf.conf
sudo systemctl restart telegraf
sudo sed -i s/STACK_ID/stack_id/g /etc/consul.d/*.json
sudo systemctl restart consul

sed -i 's/circapp/stack_id/g' /usr/local/scripts/copytos3.sh 
sed -i 's/circapp/stack_id/g' /usr/local/scripts/logrotate.sh 
sed -i 's/circdb/stack_id/g' /opt/tomcat-8/lib/*.properties

/bin/systemctl stop withdraw
rm -rf /opt/tomcat-8/webapps/*

cp -f /home/deploy/apps/withdraw/withdraw_service.war /opt/tomcat-8/webapps/withdraw_service.war

/bin/systemctl restart withdraw

