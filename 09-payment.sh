#!/bin/bash

APP_NAME="payment"
source ./functions.sh

#user validation
user_validation
app_user_setup
python_setup
service_setup
