#!/bin/bash

VALIDATE(){

    if [  $1 -eq 0 ]
    then    
        echo -e "$2 is ...... $G SUCCESS $N " | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi  
}

dnf module disable nodejs -y
VALIDATE $? "disable "

dnf module enable nodejs:20 -y
VALIDATE $? "enable"

dnf install nodejs -y
VALIDATE $? "Install"

cp catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "service cata copy"
