#---------------- RDS Instance ----------------#

resource "aws_db_instance" "mysql_rds" {
  identifier              = "my-rds"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"     
  allocated_storage       = 20
  storage_type            = "gp2"

  db_name                 = "database1"
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = "default.mysql8.0"

  db_subnet_group_name = aws_db_subnet_group.name.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7

  tags = {
    Name = "Terraform-RDS"
  }

  depends_on = [
    aws_db_subnet_group.name,
    aws_security_group.rds_sg
  ]
}

#----------------vpc-----------------#

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="rds-dev"
  }
}

#---------------Subnet--------------#

resource "aws_subnet" "name1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name="public-subnet-1"
  }
  
}
resource "aws_subnet" "name2" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name="public-subnet-2"
  }
  
}

#---------------Data-source--------------#


data "aws_subnet" "subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-1"]
  }

  depends_on = [ aws_subnet.name1 ]
}

data "aws_subnet" "subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-2"]
    
  }
  depends_on = [ aws_subnet.name2 ]
}

#-------------Subnet-group--------------#

resource "aws_db_subnet_group" "name" {
  name       = "allow"
  subnet_ids = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
  tags = {
    Name = "Sg-group"
  }
}

#----------------- Security Group ------------------#

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.name.id

  ingress {
     from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "rds-sg"
  }
}

#---------------- RDS Read Replica ----------------#

resource "aws_db_instance" "mysql_rds_replica" {
  identifier              = "my-db-replica"
  replicate_source_db     = aws_db_instance.mysql_rds.arn  # Points to primary DB
  instance_class          = "db.t3.micro"
  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false
  
  backup_retention_period = 7
  db_subnet_group_name    = aws_db_subnet_group.name.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  tags = {
    Name = "Rds-Replica"
  }

  depends_on = [
    aws_db_instance.mysql_rds,
    aws_db_subnet_group.name
  ]
}