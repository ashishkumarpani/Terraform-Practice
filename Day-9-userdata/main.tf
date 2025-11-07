provider "aws" {
  
}

#----datasource-ami------#
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

resource "aws_instance" "name" {
    ami = data.aws_ami.amzlinux.id
    instance_type = "t3.micro"
    user_data = file("test.sh")             # calling test.sh from current directory by using file fucntion 
    tags = {
      Name="ec2"
    }
  
}