#!/bin/bash

sudo yum install jq -y
hz_name=$(aws route53 list-hosted-zones |  jq '.HostedZones'[0] | jq -r '.Name' | sed 's/.$//')
hz_id=$(aws route53 list-hosted-zones |  jq '.HostedZones'[0] | jq -r '.Id' | cut -d '/' -f3)

public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
aws_account=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".accountId")
region=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")

record_name="jenkins.${hz_name}"
sns_topic_arn="arn:aws:sns:${region}:${aws_account}:Jenkins-Notifications"
echo "=============================> $record_name"

aws route53 change-resource-record-sets --hosted-zone-id "${hz_id}" --change-batch '{"Changes": [{"Action": "UPSERT","ResourceRecordSet": {"Name": "'"${record_name}"'","Type": "A","TTL": 60,"ResourceRecords": [{"Value": "'"${public_ip}"'"}]}}]}'

aws sns publish \
    --topic-arn "${sns_topic_arn}" \
    --message "Jenkins URL:- ${record_name}:8085" \
    --region "${region}"
