variable "aws_region" {
  description = "Região AWS utilizada no projeto"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome globalmente único do bucket S3"
  type        = string
}

variable "lock_table_name" {
  description = "Nome da tabela DynamoDB usada para locking"
  type        = string
  default     = "prova-primeiro-bimestre-devops-locks"
}