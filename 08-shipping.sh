#!/bin/bash

APP_NAME="shipping"
MYSQL_HOST="mysql.mrmotam.online"
source ./functions.sh

#user validation
user_validation
app_user_setup
java_setup
service_setup

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing mysql-client"

mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql &>> $LOGS_FILE
mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql &>> $LOGS_FILE
mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql &>> $LOGS_FILE
VALIDATE $? "Loading the Schema, App and Master date "

systemctl start shipping
VALIDATE $? "Retarting the shipping services"