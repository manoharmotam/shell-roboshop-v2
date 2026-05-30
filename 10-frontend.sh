#!/bin/bash

source ./functions.sh

#user validation
user_validation

dnf module disable nginx -y &>> "$LOGS_FILE"
dnf module enable nginx:1.24 -y &>> "$LOGS_FILE"
dnf install nginx -y &>> "$LOGS_FILE"
VALIDATE $? "Enabling and installing the Nginx 1.24"

rm -rf /usr/share/nginx/html/* 
VALIDATE $? "Removing existing nginx configuration"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>> "$LOGS_FILE"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>> "$LOGS_FILE"
VALIDATE $? "Downloading and updatng the config files"

rm -f /etc/nginx/nginx.conf
VALIDATE $? "Removed Default conf"

cp "$SCRIPTDIR"/configs/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "Updating the nginx config for services routing"

service_setup