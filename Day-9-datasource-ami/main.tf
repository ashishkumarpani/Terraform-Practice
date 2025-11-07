#---------DATASOURCE---------#
#----------VPC---------#

data "aws_vpc" "name" {
    default = true
      
}

#------SUBNET-------#

data "aws_subnet" "name" {
   filter {
     name = "vpc-id"
     values = [data.aws_vpc.name.id]
   }
   filter {
    name   = "availability-zone"
    values = ["us-east-1a"]
  }
}

#-------AMI--------#

data "aws_ami" "amzlinux" {
    most_recent = true
    owners = ["amazon"]
    
    filter {
      name="name"
      values = [ "amzn2-ami-hvm-*-gp2"]
    }

    filter {
      name = "root-device-type"
      values = [ "ebs" ]
    }

    filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }  
}

#-------For self owner--------#

# data "aws_ami" "amzlinux" {
#   most_recent = true
#   owners = [ "self" ]
#   filter {
#     name = "name"
#     values = [ "frontend-ami" ]
#   }

# }

#-----INSTANCE------#

resource "aws_instance" "name" {
    ami = data.aws_ami.amzlinux.id
    subnet_id = data.aws_subnet.name.id 
    instance_type = "t3.micro"
}
