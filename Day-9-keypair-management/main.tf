provider "aws" {
  
}

resource "aws_key_pair" "name" {
    key_name="terraform"
    public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t3.micro"
    key_name = aws_key_pair.name.key_name
  
}