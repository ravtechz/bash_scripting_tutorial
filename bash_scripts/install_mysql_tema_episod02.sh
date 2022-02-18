#!/bin/bash

#########################
# Error codes:          #
# 3 - Missing parameter #
#########################

# Variabile
OS=`cat /etc/os-release | grep -w "NAME" | awk -F"=" '{print $2}' | tr -d \"` # extragem sistemul de operare
LOG_DIR="/tmp"                                                                # folderul fisierului de log
LOG_NAME=$1                                                                   # numele logului
LOG_LOCATION="$LOG_DIR/$LOG_NAME.log"                                         # locatia logului = folder + numele sau

# Main

# Verif daca scriptul este rulat cu parametru sau nu
if [ $# == 0 ]
then
  echo "ERROR - You must run this script with a parameter!"
  echo "./install_mysql.sh [LOG_NAME]"
  echo "Example: ./install_mysql.sh COCINA"
  exit 3
fi

# Daca folderul de log nu exista, il cream
if [ ! -d $LOG_DIR ]
then
  mkdir -p $LOG_DIR
fi

# Verificam sistemul de operare
echo "Suntem pe: $OS" >> $LOG_LOCATION

# Instalare pachet MySQL pe Ubuntu si CentOS
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
