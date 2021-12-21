#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo systemctl start docker.service
sudo usermod -a -G docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker login --username docktor1994 --password K4BwyA3MXXK6
sudo docker run -d --rm -p 3000:3000 docktor1994/devops_practices:test_node