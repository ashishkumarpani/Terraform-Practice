module "vpc" {
    source = "../../modules/vpc"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    vpc_ig = var.vpc_ig
    pubic_subnet_1_cidr = var.pubic_subnet_1_cidr
    pubic_subnet_1_name = var.pubic_subnet_1_name
    pubic_subnet_2_cidr = var.pubic_subnet_2_cidr
    pubic_subnet_2_name = var.pubic_subnet_2_name
    az1 = var.az1
    az2=var.az2 
}

module "sg" {
  source = "../../modules/sg"  

  vpc_id  = module.vpc.vpc_id
  sg_tags = var.sg_name

  ingress_rules = [
  for port in [22, 80, 443, 3306] : {
    description      = "Allow inbound traffic on port ${port}"
    from_port        = port
    to_port          = port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
]
}


module "rds" {
  source = "../../modules/rds"
  subnet_ids=[module.vpc.public_subnet_1,module.vpc.public_subnet_2]
  db_name= var.db_name
  username= var.username
  password=var.password
  security_group_id = module.sg.sg_id
}


module "ec2" {
   source = "../../modules/ec2"
  subnet1 = module.vpc.public_subnet_1
    ami = var.ami_id
    key_pair = var.key_pair
    instance_type = var.instance_type
    name = var.name
    sg_id= module.sg.sg_id
  
}

module "s3" {
  source = "../../modules/s3"
  bucket = var.bucket
  
}

