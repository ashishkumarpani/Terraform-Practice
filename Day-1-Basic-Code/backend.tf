
terraform {
  backend "s3" {
    bucket = "terraforms3bucketttt"
    key    = "Day-1/terraform.tfstate"
    region = "us-east-1"
  }
}
