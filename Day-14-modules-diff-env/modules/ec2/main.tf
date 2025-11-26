resource "aws_instance" "name" {
    subnet_id = var.subnet1
    ami = var.ami
    key_name = var.key_pair
    instance_type = var.instance_type
    tags = {
      Name=var.name
    }
    vpc_security_group_ids = [var.sg_id]   
  
}