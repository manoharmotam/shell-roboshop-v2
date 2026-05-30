#!/bin/bash

APP_NAME="catalogue"

source ./functions.sh

#user validation
user_validation
app_user_setup
nodejs_setup
service_setup

cp "$SCRIPTDIR"/configs/mongo.repo /etc/yum.repos.d/
VALIDATE $? "Copy Mongo repo file to repo list"

dnf install mongodb-mongosh -y &>> $LOGS_FILE
VALIDATE $? "Installing the monogosh cli"

mongosh --host mongodb.mrmotam.online </app/db/master-data.js
VALIDATE $? "Setting the catalogue database"