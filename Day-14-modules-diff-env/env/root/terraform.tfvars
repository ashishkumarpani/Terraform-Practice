#------------Region-------------#
region = "us-east-1"

#----------Vpc-Module------------#

vpc_name = "root"
vpc_cidr = "10.0.0.0/16"
vpc_ig = "root-ig"
az1 = "us-east-1a"
az2 = "us-east-1b"
pubic_subnet_1_cidr = "10.0.0.0/24"
pubic_subnet_1_name = "root-pub-1"
pubic_subnet_2_cidr = "10.0.1.0/24"
pubic_subnet_2_name = "root-pub-2"

#-----------sg------------#
sg_name = "root-sg"

#-----rds-----#
db_name = "root"
username = "ashish"
password = "ashish2003"

#--------ec2--------#
name = "root-ec2"
instance_type = "t3.micro"
ami_id = "ami-0cae6d6fe6048ca2c"
key_pair = "server-01"

#---------s3----------#
bucket="root-14-11-25"
