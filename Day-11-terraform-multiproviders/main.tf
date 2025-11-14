#-------------Region-North Virginia--------------#

resource "aws_instance" "name" {
 ami="ami-07860a2d7eb515d9a"
 instance_type = "t3.micro"
 key_name = data.aws_key_pair.name.key_name
 tags = {
   Name="northvirginia"
 }
}


data "aws_key_pair" "name" {
  key_name = "server-01"
  
}

#----------Mumbai Region-------------#

resource "aws_instance" "name1" {
 ami="ami-03695d52f0d883f65"
 instance_type = "t3.micro"
 key_name = data.aws_key_pair.name1.key_name
 tags = {
   Name="mumbai"
 }
 provider = aws.mumbai
}


data "aws_key_pair" "name1" {
  key_name = "mumbai-key"
  provider = aws.mumbai
  
}


