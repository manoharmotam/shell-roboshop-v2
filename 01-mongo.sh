#!/bin/bash

APP_NAME=mongod
source ./functions.sh

#user validation
user_validation

cp configs/mongo.repo /etc/yum.repos.d/
VALIDATE $? "Copy Mongo repo file to repo list"

dnf install mongodb-org -y &>> $LOGS_FILE
VALIDATE $? "Installation is complete"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Enabled remote connections to mongodb"

systemctl enable mongod &>> $LOGS_FILE
systemctl restart mongod
VALIDATE $? "MongoD Services restarted"




