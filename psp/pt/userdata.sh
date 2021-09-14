#!/bin/bash

exec 2> /var/log/user-data.log # send stderr to a log file
exec 1>&2  # send stdout to the same log file
set -x   # tell sh to display commands before execution


sudo sed -i s/STACK_ID/stack_id/g /etc/telegraf/telegraf.conf
sudo systemctl restart telegraf
sudo sed -i s/STACK_ID/stack_id/g /etc/consul.d/*.json
sudo systemctl restart consul
/bin/systemctl status player-service-portal
ls -la /opt/tomcat-8/webapps/
mkdir -p /opt/tomcat-8/vhost.d/
cp /home/deploy/apps/player-service-portal/pt/server.xml /opt/tomcat-8/conf/
cp /home/deploy/apps/player-service-portal/pt/psp.rummycircle.com_http_tomcat.vhost /opt/tomcat-8/vhost.d/

sed -i 's/circapp/stack_id/g' /usr/local/scripts/copytos3.sh
sed -i 's/circapp/stack_id/g' /usr/local/scripts/logrotate.sh 

/bin/systemctl stop player-service-portal
rm -rf /opt/tomcat-8/webapps/*

cp -f /home/deploy/apps/player-service-portal/player-service-portal.war /opt/tomcat-8/webapps/player-service-portal.war

/bin/systemctl restart player-service-portal

sed -i 's/circdb/stack_id/g' /opt/tomcat-8/vhost.d/*

sed -i 's/circdb/stack_id/g' /opt/tomcat-8/lib/*.properties

sed -i "s/circdb/stack_id/g"  /opt/tomcat-8/vhost.d/psp.rummycircle.com_http_tomcat.vhost
sed -i "s/fmscash6-//g"  /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/db-master.pdc.games24x7.com/stack_id-mysql-master1.stage-rc.in/g" /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/dbs7.pdc.games24x7.com/stack_id-mysql-slave1.stage-rc.in/g" /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/db-passiveslave2.pdc.games24x7.com/stack_id-mysql-slave2.stage-rc.in/g" /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/fms/games24x7v2/g" /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/a_games24x7v2/games24x7v2/g"  /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/psp.rummycircle.com/stack_id-psp.fickle.rummycircle.com/g"  /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/application-security.xml
sed -i "s/cepdb.pdc.games24x7.com/stack_id-mysql-master1.stage-rc.in/g" /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/fmscash6-db-master.pdc.games24x7.com/stack_id-mysql-master1.stage-rc.in/g" /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/fmscash6-db-passiveslave2.pdc.games24x7.com/stack_id-mysql-slave1.stage-rc.in/g" /opt/tomcat-8/webapps/player-service-portal/WEB-INF/config/xml/spring/applicationContext.xml
sed -i "s/player-service-portal\/webapp\//player-service-portal/g" /opt/tomcat-8/vhost.d/psp.rummycircle.com_http_tomcat.vhost

cd /opt/tomcat-8/webapps/player-service-portal/WEB-INF/lib/
rm -rf ehcache-2.10.0.jar hibernate-jpa-2.0-api-1.0.1.Final.jar  hibernate_games24x7-0.0.11.jar hibernate-core-5.0.4.Final.jar hibernate-commons-annotations-5.0.0.Final.jar   slf4j-log4j12-1.7.25.jar hibernate_pkr-0.0.3-SNAPSHOT.jar httpclient-4.0-alpha4.jar httpcore-4.0-beta1.jar hibernate_pkr-0.0.3-SNAPSHOT.jar
