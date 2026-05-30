#!/bin/bash

source ./functions.sh
#user validation
user_validation

dnf install mysql-server -y &>> $LOGS_FILE
VALIDATE $? "Installing mysql-server"

systemctl enable mysqld &>> $LOGS_FILE
systemctl restart mysqld
VALIDATE $? "Restarting mysql-services"

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "Setting up the root user"