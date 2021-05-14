#!/bin/bash

# Install docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

public_dns=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
jenkins_url=http://$public_dns:8085/

mkdir -p $HOME/playground/jcasc
mkdir -p $HOME/dns 
cp * $HOME/playground/jcasc/
cp ../scripts/* $HOME/dns/
cd $HOME/playground/jcasc
sed -i "s|url:.*|url: $jenkins_url|" casc.yaml
docker stop jenkins
docker rm jenkins
docker build -t jenkins:jcasc .
docker run -d --name jenkins -p 8085:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=$1 jenkins:jcasc
cd $HOME/dns/
sudo chmod +x route53.sh
sh route53.sh
