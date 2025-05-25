#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0499ce052d4a6c9a2"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z041097235OVJ7AUAD5IE"
DOMAINE_NAME="srivenkata.shop"

for instance in "${INSTANCES[@]}"
do
    echo "Launching instance: $instance"
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id "$AMI_ID" \
        --instance-type t2.micro \
        --security-group-ids "$SG_ID" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
        --query "Instances[0].InstanceId" --output text)
    if [ -z "$INSTANCE_ID" ]; then
        echo "Failed to launch instance for $instance"
        exit 1
    fi
    echo "Instance ID: $INSTANCE_ID"

    aws ec2 wait instance-running --instance-ids $INSTANCE_ID

    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
        RECORD_NAME="$instance.$DOMAIN_NAME"
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
        RECORD_NAME="$DOMAIN_NAME"
    fi

    if [ -z "$IP" ]; then
        echo "Failed to retrieve IP address for $instance"
        exit 1
    fi
    echo "$instance IP address: $IP"

    echo "Updating Route 53 for $RECORD_NAME with IP $IP"
    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '{
        "Comment": "Creating or Updating a record set for cognito endpoint",
        "Changes": [{
            "Action"              : "UPSERT",
            "ResourceRecordSet"  : {
                "Name"              : "'$RECORD_NAME'",
                "Type"             : "A",
                "TTL"              : 300,
                "ResourceRecords"  : [{
                    "Value"         : "'$IP'"
                }]
            }
        }]
    }'
    if [ $? -ne 0 ]; then
        echo "Failed to update Route 53 for $instance"
        exit 1
    fi
done
