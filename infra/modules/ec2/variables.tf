variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "ami_id" {
  description = "AMI utilizada pela EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet pública onde a EC2 será criada"
  type        = string
}

variable "security_group_id" {
  description = "Security Group da EC2"
  type        = string
}

variable "instance_profile_name" {
  description = "Nome do Instance Profile disponibilizado pelo AWS Academy"
  type        = string
}

variable "db_host" {
  description = "Endpoint do RDS PostgreSQL"
  type        = string
}

variable "db_port" {
  description = "Porta do RDS PostgreSQL"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}