resource "aws_instance" "name" { 
    instance_type = var.type
     ami = var.ami_id
     tags = {
       Name = "dev"
     }
  
}

resource "aws_s3_bucket" "name" {
    bucket = "aws-s3-buckettttttt"
    
  
}