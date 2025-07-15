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
VALIDATE $? "diable"
dnf module enable nodejs:20 -y
VALIDATE $? "Enabling nodejs:20"
dnf install nodejs -y
VALIDATE $? "install"
cp catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "cp service"
cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "cp mongodb"
useradd roboshop
VALIDATE $? "useradd roboshop"
rm -rf /app
mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
VALIDATE $? "download zip"
cd /app
unzip /tmp/catalogue.zip
VALIDATE $? "unzip"
cd /app
npm install
VALIDATE $? "install npm"
systemctl daemon-reload
VALIDATE $? "reoload"
systemctl enable catalogue
VALIDATE $? "enable"
systemctl start catalogue
VALIDATE $? "start"
dnf install mongodb-mongosh -y
VALIDATE $? "mongoad"


mongosh --host mongodb.jaiganesha.shop </app/db/master-data.js
VALIDATE $? "mongoad"
