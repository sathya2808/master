#!/bin/bash

sed -i 's/^\([^#].*\)/# \1/g' */userdata.sh
echo "###############################" | tee -a */userdata.sh
echo "sudo sed -i "s/STACK_ID/stack_id/g" /etc/telegraf/telegraf.conf" | tee -a */userdata.sh
echo "sudo systemctl restart telegraf" | tee -a */userdata.sh
echo "sudo sed -i "s/STACK_ID/stack_id/g" /etc/consul.d/*.json" | tee -a */userdata.sh
echo "sudo systemctl restart consul" | tee -a */userdata.sh
echo "###############################" | tee -a */userdata.sh
