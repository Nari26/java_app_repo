#!/bin/bash

hz_name=$(aws route53 list-hosted-zones |  jq '.HostedZones'[0] | jq -r '.Name')
hz_id=$(aws route53 list-hosted-zones |  jq '.HostedZones'[0] | jq -r '.Id' | cut -d '/' -f3)

public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

record_name="jenkins.${hz_name}"
echo $record_name

aws route53 change-resource-record-sets --hosted-zone-id "${hz_id}" --change-batch '{"Changes": [{"Action": "UPSERT","ResourceRecordSet": {"Name": "'"${record_name}"'","Type": "A","TTL": 60,"ResourceRecords": [{"Value": "'"${public_ip}"'"}]}}]}'


