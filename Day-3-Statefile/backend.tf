terraform {
  backend "s3" {
    bucket = "terraforms3bucketttt"
    key    = "Day-3/terraform.tfstate"
    region = "us-east-1"
  }
}
