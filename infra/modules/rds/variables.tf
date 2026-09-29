variable "project_name" {
  description = "Nome do projeto"
  type        = string
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

variable "subnet_ids" {
  description = "Subnets privadas do RDS"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group do RDS"
  type        = string
}

variable "instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}