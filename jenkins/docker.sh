#!/bin/bash

# Install docker 
sudo yum install docker -y 
sudo systemctl start docker 
sudo systemctl enable docker 
sudo systemctl status docker 

mkdir -p $HOME/playground/jcasc
cp -R . $HOME/playground/jcasc/
cd $HOME/playground/jcasc

docker build -t jenkins:jcasc .
docker run -d --name jenkins -p 8085:8080 jenkins:jcasc
