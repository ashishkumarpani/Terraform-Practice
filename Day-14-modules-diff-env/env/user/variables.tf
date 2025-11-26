#----Region-----#
variable "region" {
  default = ""
  type = string
  
}


#----------VPC-module----#
variable "vpc_cidr" {
  default = ""
  type = string
}
variable "vpc_name" {
  default = ""
  type = string
}

variable "vpc_ig" {
  default = ""
  type = string
}
variable "pubic_subnet_1_cidr" {
  default = ""
  type = string
}
variable "pubic_subnet_1_name" {
  default = ""
  type = string
}
variable "pubic_subnet_2_cidr" {
  default = ""
  type = string
}
variable "pubic_subnet_2_name" {
  default = ""
  type = string
}
variable "az1" {
  default = ""
  type = string
}
variable "az2" {
  default = ""
  type = string
}

#==========SG====================#
# Security Group name
variable "sg_name" {
 default =""
 type = string   
}

#--------------rds----------------#
variable "db_name" {
  type = string
  default = ""
}

variable "username" {
  type = string
  default = ""
}

variable "password" {
  type = string
  default = ""
  
}

#--------ec2-----------#
variable "ami_id" {
  type = string
  default = ""
}

variable "instance_type" {
  type = string
  default = ""
}

variable "name" {
  type = string
   default = ""
  
}
variable "key_pair" {
  type = string
 default = ""  
}

#------S3------#
variable "bucket" {
  type = string
  default = ""
  
}
