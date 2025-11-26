resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids
  description = "Subnet group for RDS"
}

resource "aws_db_instance" "this" {
  identifier           = var.db_name
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  instance_class       = var.instance_class
  db_name                 = var.db_name
  username             = var.username
  password             = var.password
  skip_final_snapshot  = true

  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.this.name
  depends_on = [aws_db_subnet_group.this]
}