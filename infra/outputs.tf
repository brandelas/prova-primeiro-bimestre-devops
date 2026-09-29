output "vpc_id" {
  description = "ID da VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = module.vpc.private_subnet_ids
}

output "ec2_security_group_id" {
  description = "ID do Security Group da EC2"
  value       = module.security_group.ec2_security_group_id
}

output "rds_security_group_id" {
  description = "ID do Security Group do RDS"
  value       = module.security_group.rds_security_group_id
}

output "ec2_public_ip" {
  description = "IP público da EC2"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "DNS público da EC2"
  value       = module.ec2.public_dns
}

output "rds_endpoint" {
  description = "Endpoint do RDS PostgreSQL"
  value       = module.rds.db_endpoint
}

output "rds_port" {
  description = "Porta do RDS PostgreSQL"
  value       = module.rds.db_port
}

output "api_url" {
  description = "URL pública da API"
  value       = "http://${module.ec2.public_ip}:3000"
}