#!/bin/bash

# Install docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

mkdir -p $HOME/playground/jcasc
cp * $HOME/playground/jcasc/
cd $HOME/playground/jcasc
docker stop jenkins
docker rm jenkins
docker build -t jenkins:jcasc .
docker run -d --name jenkins -p 8085:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=$1 jenkins:jcasc
