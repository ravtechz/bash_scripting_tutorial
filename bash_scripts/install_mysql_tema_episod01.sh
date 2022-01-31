#!/bin/bash

# Variabile
OS=`cat /etc/os-release | grep -w "NAME" | awk -F"=" '{print $2}' | tr -d \"`

# Main
echo "Suntem pe: $OS"

if [[ $OS == "Ubuntu" ]]
then
  # Install mysql
  sudo apt install mysql-server

  # Verif Status
  STATUS=`service mysql status | grep Active | awk '{print $2}'`
  echo "====== MY STATUS IS: $STATUS ======="
  if [ $STATUS == "inactive" ]
  then
    sudo service mysql start
    service mysql status
    echo "===== MYSQL Service Started on $OS ===="
  fi
elif [[ $OS == "CentOS Linux" ]]
then
  # Install mysql
  wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
  sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
  sudo yum install -y mysql-server

  # Verif Status
  STATUS=`service mysqld status | grep Active | awk '{print $2}'`
  echo "====== MY STATUS IS: $STATUS ======="
  if [ $STATUS == "inactive" ]
  then
    sudo service mysqld start
    service mysqld status
    echo "===== MYSQL Service Started on $OS ===="
  fi
else
  echo "Nu e nici Ubuntu nici CentOS boss."
fi
