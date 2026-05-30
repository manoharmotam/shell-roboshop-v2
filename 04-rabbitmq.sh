#!/bin/bash

source ./functions.sh
#user validation
user_validation



cp configs/rabbitmq.repo /etc/yum.repos.d/
VALIDATE $? "Copy RabbitMQ repo file to repo list"

dnf install rabbitmq-server -y &>> $LOGS_FILE
VALIDATE $? "Installation is complete"

systemctl enable rabbitmq-server &>> $LOGS_FILE
systemctl restart rabbitmq-server
VALIDATE $? "RabbitMQ Services restarted"

rabbitmqctl add_user roboshop roboshop123 &>> $LOGS_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "Setting up RabbitMQ user"