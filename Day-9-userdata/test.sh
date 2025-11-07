#! /bin/bash
yum install git -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>AWS Infrastructure created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html