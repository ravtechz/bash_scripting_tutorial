#!/bin/bash

# Variabile
OS=`cat /etc/os-release | grep -w "NAME" | awk -F"=" '{print $2}' | tr -d \"`

# Main
echo "Suntem pe: $OS"

if [[ $OS == "Ubuntu" ]]
then
  sudo apt install mysql-server
elif [[ $OS == "CentOS Linux" ]]
then
  wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
  sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
  sudo yum install -y mysql-server 
else
  echo "Nu e nici Ubuntu nici CentOS boss."
fi


