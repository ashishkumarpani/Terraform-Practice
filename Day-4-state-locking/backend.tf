terraform {
  backend "s3" {
    bucket = "terraform-bucket-state-file-storage"
    key    = "Day-4/terraform.tfstate"
    use_lockfile = true # to use s3 native locking 1.19 version above
    region = "us-east-1"
    #dynamodb_table = "Ashish" # any version we can use dynamodb locking 
    #encrypt = true
  }
}
