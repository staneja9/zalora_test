#!/bin/bash -ex

echo Begin: user-data

echo Begin: update and install packages
sudo yum update -y
sudo yum install -y aws-cli jq
echo End: update and install packages

echo changing time zone from UTC to European Time and enabling ntp server

sudo sed -i 's/ZONE=\"UTC\"/ZONE=\"Singapore\"/g' /etc/sysconfig/clock
sudo ln -sf /usr/share/zoneinfo/Singapore /etc/localtime
sudo service ntpd restart
sudo chkconfig ntpd on

echo finished ntp configuration

echo deploying hello-world application

sudo yum install -y httpd24 php56
sudo service httpd start
sudo chkconfig httpd on
sudo echo "hello World" > /var/www/html/index.php
