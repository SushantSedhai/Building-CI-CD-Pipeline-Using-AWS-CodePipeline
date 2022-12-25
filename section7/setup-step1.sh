#!/bin/bash

echo Install and run docker...

sudo yum install docker;
sudo systemctl enable docker.service;
sudo systemctl start docker.service;

#echo Run all docker commands without using the sudo command...

#sudo usermod -a -G docker ec2-user;
#id ec2-user;
#newgrp docker;

echo create docker image...
	
sudo docker pull nginx;
aws ecr create-repository --repository-name nginx;
sudo docker tag nginx:latest <your_aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/nginx:latest;
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your_aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/nginx;

echo push image to an Amazon ECR repository...
sudo docker push <your_aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/nginx:latest;


