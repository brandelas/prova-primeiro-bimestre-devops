output "state_bucket_name" {
  description = "Nome do bucket S3 do Terraform State"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "lock_table_name" {
  description = "Nome da tabela DynamoDB de locking"
  value       = aws_dynamodb_table.terraform_lock.name
}