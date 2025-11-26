resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
  tags = {
    Name=var.vpc_name
  }
}

resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags={
        Name=var.vpc_ig
    }
  
}

resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.pubic_subnet_1_cidr
    availability_zone = var.az1
    tags = {
        Name=var.pubic_subnet_1_name
    }
  
}
resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.pubic_subnet_2_cidr
    availability_zone = var.az2
    tags = {
        Name=var.pubic_subnet_2_name
    }
  
}
