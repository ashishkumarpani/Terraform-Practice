provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "name" {
 ami="ami-07860a2d7eb515d9a"
 instance_type = "t3.micro"
 key_name = aws_key_pair.name.key_name
 tags = {
   Name="prod"
 }
}

resource "aws_key_pair" "name" {
    key_name = "terraform"
    public_key = file("~/.ssh/id_ed25519.pub")
}


# data "aws_key_pair" "name" {
#   key_name = "terraform"
  
# }

# terraform workspace 

#--> terraform workspace is used to manage multiple environments 
# (like dev, test, prod) within the same Terraform configuration — without duplicating your code.