#!/bin/sh

  
  apt-get update
  DEBIAN_FRONTEND=noninteractive \
  apt-get \
  -o Dpkg::Options::=--force-confold \
  -o Dpkg::Options::=--force-confdef \
  -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
  dist-upgrade

  echo " adding pgdg.list "
  cp /vagrant_data/pgdg.list /etc/apt/sources.list.d/pgdg.list
  #sudo add-apt-repository "deb https://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main"
  #echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
  echo "getting psql install  keys"
  #apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7FCC7D46ACCC4CF8
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - 
  DEBIAN_FRONTEND=noninteractive apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get -y install postfix


  echo "install aptitude"

  DEBIAN_FRONTEND=noninteractive apt-get install aptitude -yq
  
  #DEBIAN_FRONTEND=noninteractive apt-get install ruby-dev build-essential -yq

  echo "installing unattended  up"
  DEBIAN_FRONTEND=noninteractive apt-get install unattended-upgrades -yq

  echo "copy unattended  upgrades  files  into place"


  cp /vagrant_data/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
  cp /vagrant_data/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

  DEBIAN_FRONTEND=noninteractive apt-get install nginx -yq
  echo " open firewall ports "
  sudo ufw allow 'Nginx Full'
  echo "coderz.io is johns  company"
  sudo mkdir -p /var/www/coderz.io/public_html
  cp /vagrant_data/index.html /var/www/coderz.io/public_html/index.html

  echo " ssl cert"
  DEBIAN_FRONTEND=noninteractive apt-get install certbot -yq

  echo "this took a minute and  typed a lot of  red "
  sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 -yq
  cp /vagrant_data/ssl.conf /etc/nginx/snippets/ssl.conf
  echo "Install Postgresql"
  
  DEBIAN_FRONTEND=noninteractive apt-get install postgresql postgresql-contrib -yq
  echo "install libpq"
  cp /vagrant_data/pg_hba.conf /etc/postgresql/11/main/pg_hba.conf   
  DEBIAN_FRONTEND=noninteractive apt-get install libpq-dev -yq
  echo "download mattermost package"
  wget --quiet -O mattermost-5.12.0-linux-amd64.tar.gz https://releases.mattermost.com/5.12.0/mattermost-5.12.0-linux-amd64.tar.gz
  echo "unpack mattermost"
  tar zxf mattermost-5.12.0-linux-amd64.tar.gz  -C /opt
  mkdir -p /opt/mattermost/data

  echo "commented  out changing ownership b/c i have not  created  the  user  yet"
  #sudo chown -R mattermost: /opt/mattermost
  cp /vagrant_data/mattermost.service /etc/systemd/system/mattermost.service

  sudo --login --user postgres

  #echo "change to postgres user"
  #sudo -su postgres 
  #update-rc.d postgresql enable

  # service postgresql start

  #john wants mattermost installed..




  #/usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main -l logfile start

  #some cleanup


  
 

  #inttialize and  import  datafile
  createdb dvdrental -U postgres

  #sudo -u postgres pg_restore -d dvdrental /vagrant_data/dvdrental -c







