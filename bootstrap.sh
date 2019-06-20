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
  
  DEBIAN_FRONTEND=noninteractive apt-get install ruby-dev build-essential -yq

  echo "installing unattended  up"
  DEBIAN_FRONTEND=noninteractive apt-get install unattended-upgrades -yq

  echo "copy unattended  upgrades  files  into place"


  cp /vagrant_data/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
  cp /vagrant_data/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

  #apt-get install bsd-mailx -yq
  DEBIAN_FRONTEND=noninteractive apt-get install nginx -yq
  DEBIAN_FRONTEND=noninteractive apt-get install certbot -yq
  echo "Install Postgresql"
  DEBIAN_FRONTEND=noninteractive apt-get install postgresql postgresql-contrib -yq
  echo "install libpq"
  DEBIAN_FRONTEND=noninteractive apt-get install libpq-dev -yq
  wget --quiet -O mattermost-5.12.0-linux-amd64.tar.gz https://releases.mattermost.com/5.12.0/mattermost-5.12.0-linux-amd64.tar.gz
  tar zxf mattermost-5.12.0-linux-amd64.tar.gz  -C /opt
  mkdir -p /opt/mattermost/data

  

  #update-rc.d postgresql enable

  sudo service postgresql start

  #john wants mattermost installed..




  #/usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main -l logfile start

  #some cleanup


  
  sudo -su postgres 

  #inttialize and  import  datafile
  createdb dvdrental

  #sudo -u postgres pg_restore -d dvdrental /vagrant_data/dvdrental -c







