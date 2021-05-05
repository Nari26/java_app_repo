#!/bin/bash 

# add jenkins repo
sudo yum install wget -y 
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# intall java, jenkins 
sudo yum install java-1.8.0-openjdk -y
sudo yum install jenkins -y

# start & enable jenkins 
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

# install maven 
sudo yum install maven -y
