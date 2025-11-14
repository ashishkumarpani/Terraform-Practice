# resource "aws_instance" "name" {
#     ami="ami-0cae6d6fe6048ca2c"
#     instance_type = "t3.micro"
#     count=2                                          # TWO INSTANCE CREATED
#     tags={
#         Namwe="dev"
#     }  
# }



resource "aws_instance" "example" {
  ami           = "ami-0cae6d6fe6048ca2c"
  instance_type = "t3.micro"
  count = 2

  tags = {
    Name = "DEV-${count.index}"
  }
}


# resource "aws_instance" "name" {
#     ami="ami-0cae6d6fe6048ca2c"
#     instance_type = "t3.micro"
#     count=length(var.env)                                          
#     tags={
#         Name=var.env[count.index]
#     }  
# }


# i want to delete dev so i  remove dev but prod willl be detroyed ....
#  test-->dev or prod-->test, prod deleted
# to overcome thios we use for-each


#s3
# resource "aws_s3_bucket" "name" {
#     count = length(var.env)
#     bucket = var.env[count.index]
# }


