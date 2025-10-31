resource "aws_instance" "test" {
    ami = "ami-0bdd88bd06d16ba03"
    instance_type = "t3.micro"
    tags = {
      Name = "test"
    }

    # lifecycle {
    #  create_before_destroy = true
    # }
    # lifecycle {
    #   ignore_changes = [tags,  ]
    # }
    # lifecycle {
    #   prevent_destroy = true
    # }
  
}
