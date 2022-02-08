#!/bin/bash

# Variabile
OS=`cat /etc/os-release | grep -w "NAME" | awk -F"=" '{print $2}' | tr -d \"`
LOG_LOCATION=$1
#LOG_LOCATION="/tmp/log.txt"

# Main
echo "Suntem pe: $OS" >> $LOG_LOCATION

if [[ $OS == "Ubuntu" ]]
then
  # Install mysql
  sudo apt install mysql-server >> $LOG_LOCATION

  # Verif Status
  STATUS=`service mysql status | grep Active | awk '{print $2}'`
  echo "====== MY STATUS IS: $STATUS =======" >> $LOG_LOCATION
  if [ $STATUS == "inactive" ]
  then
    sudo service mysql start >> $LOG_LOCATION
    service mysql status >> $LOG_LOCATION
    echo "===== MYSQL Service Started on $OS ====" >> $LOG_LOCATION
  fi
elif [[ $OS == "CentOS Linux" ]]
then
  # Install mysql
  wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm >> $LOG_LOCATION
  sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm >> $LOG_LOCATION
  sudo yum install -y mysql-server >> $LOG_LOCATION

  # Verif Status
  STATUS=`service mysqld status | grep Active | awk '{print $2}'`
  echo "====== MY STATUS IS: $STATUS =======" >> $LOG_LOCATION
  if [ $STATUS == "inactive" ]
  then
    sudo service mysqld start >> $LOG_LOCATION
    service mysqld status >> $LOG_LOCATION
    echo "===== MYSQL Service Started on $OS ====" >> $LOG_LOCATION
  fi
else
  echo "Nu e nici Ubuntu nici CentOS boss." >> $LOG_LOCATION
fi
