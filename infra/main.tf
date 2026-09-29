module "vpc" {
  source = "./modules/vpc"

  project_name       = "prova-primeiro-bimestre-devops"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
}

module "security_group" {
  source = "./modules/security-group"

  project_name = "prova-primeiro-bimestre-devops"
  vpc_id       = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  project_name          = "prova-primeiro-bimestre-devops"
  ami_id                = var.ami_id
  instance_type         = "t2.micro"
  subnet_id             = module.vpc.public_subnet_ids[0]
  security_group_id     = module.security_group.ec2_security_group_id
  instance_profile_name = var.instance_profile_name

  db_host     = module.rds.db_endpoint
  db_port     = module.rds.db_port
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

module "rds" {
  source = "./modules/rds"

  project_name      = "prova-primeiro-bimestre-devops"
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_group.rds_security_group_id
  instance_class    = "db.t3.micro"
}