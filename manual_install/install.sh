#!/bin/bash

#install packages
apt-get install -y apache2 python3 python3-pip python3-venv

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

chown -r ubuntu:ubuntu /var/www/the-system-app/

#create virtual env
#current_dir=$pwd
cd /var/www/the-system-app/
python3 -m venv env
source env/bin/activate

#install python packages
pip3 install -r requirements.txt
#cd $current_dir
gunicorn -c gunicorn.conf -b 0.0.0.0:5000 the-system:app

