#!/bin/bash

#install packages
apt-get install -y apache2 python3 python3-pip

#install mongodb
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

apt-get update

apt-get install -y mongodb-org

#enable apache mods and config
a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html

cp 000-default.conf /etc/apache2/sites-available/000-default.conf

#move flask app to correct dir and give permissions to ubuntu user
cp -r the-system-app/ /var/www/

chown -R ubuntu:ubuntu /var/www/the-system-app/

#install python packages
pip3 install -r /var/www/the-system-app/requirements.txt

#create systemd service file for our app
cp the-system.service /etc/systemd/system/
systemctl daemon-reload # to activate our .service file
systemctl enable the-system # to enable our app at boot
systemctl start the-system # to run our app
