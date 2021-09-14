#!/bin/bash

exec 2> /var/log/user-data.log # send stderr to a log file
exec 1>&2  # send stdout to the same log file
set -x   # tell sh to display commands before execution

sudo sed -i s/STACK_ID/stack_id/g /etc/telegraf/telegraf.conf
sudo systemctl restart telegraf
sudo sed -i s/STACK_ID/stack_id/g /etc/consul.d/*.json
sudo systemctl restart consul

sudo /bin/systemctl stop complex-event-processing
sed -i 's/circapp/stack_id/g' /usr/local/scripts/copytos3.sh 
sed -i 's/circapp/stack_id/g' /usr/local/scripts/logrotate.sh 

sed -i 's/circdb/stack_id/g' /home/deploy/apps/complex-event-processing/pt/*.properties

sudo /bin/systemctl start complex-event-processing
