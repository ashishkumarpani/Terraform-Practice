resource "aws_instance" "name" {
  ami = "ami-0bdd88bd06d16ba03"
  instance_type = "t3.micro"
  tags = {
    Name = "test"
  }

}

# Command to Import---> terraform import aws_instance.name i-09746c4c5429890ef
