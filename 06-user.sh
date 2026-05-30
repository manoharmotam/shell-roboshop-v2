#!/bin/bash

APP_NAME="user"
source ./functions.sh

#user validation
user_validation
app_user_setup
nodejs_setup
service_setup