
terraform {
  backend "s3" {
    bucket = "terraforms3bucketttt"
    key    = "Day-2/terraform.tfstate"
    region = "us-east-1"
  }
}
