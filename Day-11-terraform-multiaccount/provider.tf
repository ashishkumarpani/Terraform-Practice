provider "aws" {
    region = "us-east-1"
  
}

provider "aws" {
    region = "ap-south-1"
    alias = "mumbai"
    profile = "ashu"
  
}


# alias used to create multiple configuration inside provider block

# for multi account configure accesskey and secret key