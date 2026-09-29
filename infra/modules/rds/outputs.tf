output "db_instance_id" {
  description = "ID da instância RDS"
  value       = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "Endpoint do RDS"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "Porta do RDS"
  value       = aws_db_instance.this.port
}