#Creation of vpc

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Dev"
    }  
}

#creation Of Internet gateway & attch to vpc

resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "dev_ig"
    }
  
}

#Creation of public subnet-1 at 1a-az

resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "subnet-01-public"
    }
  
}

#Creation of public subnet-2  at 1b-az

resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "subnet-02-public"
    }
  
}

#Creation of private subnet-1  at 1a-az

resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "subnet-01-pvt"
    }
  
}

#Creation of private subnet-2  at 1b-az

resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "subnet-02-pvt"
    }
  
}

#Creation of routetable for public subnet

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
    tags = {
      Name = "public-rt"
    }
  
}

# Subnet association for Public Subnet 1

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

# Subnet association for Public Subnet 2

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

#Elastic_ip

resource "aws_eip" "public_ip" {
  domain = "vpc"  # required for VPC-based EIPs

  tags = {
    Name = "public-eip"
  }
}

#creation of NAT-GATEWAY which associated with eip and attched to public subnet-1

resource "aws_nat_gateway" "name" {
    allocation_id = aws_eip.public_ip.id
    subnet_id = aws_subnet.public1.id
  
}

#Creation of Route-table for pvt subnet association 

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.name.id
    }
    tags = {
      Name = "private-rt"
    }
  
}

# Subnet association for Private Subnet 1

resource "aws_route_table_association" "private1" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.private.id
  
}

# Subnet association for Private Subnet 2

resource "aws_route_table_association" "private2" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.private.id
  
}

#Creation of SG

resource "aws_security_group" "name" {
    name = "allow"                  #description
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "dev_SG"
    }

    ##Inbound Rules

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #Outbound rule

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"         #all protocol
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Create public Instance

resource "aws_instance" "public" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.public1.id
    associate_public_ip_address = true
    tags = {
        Name = "public-ec2"
    }
   vpc_security_group_ids = [aws_security_group.name.id]
 

  
}

#Creation private Instance

resource "aws_instance" "private" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.private2.id
    tags = {
      Name = "pvt-ec2"
    }
    vpc_security_group_ids = [aws_security_group.name.id]

  
}