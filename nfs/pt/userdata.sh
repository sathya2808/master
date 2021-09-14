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

sleep 5

/bin/systemctl stop non-financial
rm -rf /opt/tomcat-8/webapps/*

cp -f /home/deploy/apps/non-financial/nfs.war /opt/tomcat-8/webapps/nfs.war

/bin/systemctl restart non-financial

sed -i 's#jdbc:mysql:loadbalance://dbs10.pdc.games24x7.com:3306,dbs15.pdc.games24x7.com:3306/games24x7v2?loadBalanceStrategy=com.mysql.jdbc.SequentialBalanceStrategy#jdbc:mysql:loadbalance://stack_id-mysql-slave1.stage-rc.in:3306,stack_id-mysql-slave2.stage-rc.in:3306/games24x7v2?loadBalanceStrategy=com.mysql.jdbc.SequentialBalanceStrategy#g' /opt/tomcat-8/webapps/nfs/WEB-INF/spring/nfs-context.xml
sed -i 's#jdbc:mysql://db-master.pdc.games24x7.com:3306/games24x7v2#jdbc:mysql://stack_id-mysql-master1.stage-rc.in:3306/games24x7v2#g' /opt/tomcat-8/webapps/nfs/WEB-INF/spring/nfs-context.xml


