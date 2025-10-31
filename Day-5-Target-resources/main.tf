

resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    instance_type = "t3.micro"
    availability_zone = "us-east-1a"
    tags = {
        Name = "test"
    }

}

resource "aws_s3_bucket" "name" {
    bucket = "awscloudbuckettdevops"
  

}


#target resource we can use to apply specific resource level only below command is the reference...
#terraform apply -target=aws_s3_bucket.name
