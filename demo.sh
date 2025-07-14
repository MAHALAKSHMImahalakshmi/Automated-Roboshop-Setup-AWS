#!/bin/bash

SCRIPT_DIR=$PWD
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

id roboshop #  output 0
if [ $? -ne 0 ]
then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
    VALIDATE $? "Creating roboshop system user"
else
    echo -e "System user roboshop already created ... $Y SKIPPING $N"
fi

rm -rf /app/*
mkdir -p  /app
VALIDATE $? "creatsed app dir"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
VALIDATE $? "catalogue download"
cd /app

unzip /tmp/catalogue.zip
VALIDATE $? "unzip"
cd /app
npm install
VALIDATE $? "npm"


systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y


STATUS=$(mongosh --host mongodb.jaiganesha.shop --eval 'db.getMongo().getDBNames().indexOf("catalogue")')
if [ $STATUS -lt 0 ]
then
    mongosh --host mongodb.jaiganesha.shop </app/db/master-data.js

else
    echo -e "Data is already loaded ... $Y SKIPPING $N"
fi