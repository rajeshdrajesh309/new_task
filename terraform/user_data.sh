#!/bin/bash

dnf update -y

dnf install docker -y

systemctl enable docker

systemctl start docker

usermod -aG docker ec2-user

mkdir -p /opt/application

echo "Application Server Provisioned Successfully" > /opt/application/status.txt
