variable "aws_region" {
  description = "Região AWS utilizada no projeto"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI da EC2 para a região escolhida"
  type        = string
}

variable "instance_profile_name" {
  description = "Instance Profile disponibilizado pelo AWS Academy"
  type        = string
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuário do PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Senha do PostgreSQL"
  type        = string
  sensitive   = true
}