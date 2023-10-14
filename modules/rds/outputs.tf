output "consumer_security_group_id" {
  value = aws_security_group.consumer.id
}

output "secret_arn" {
  value = aws_secretsmanager_secret.this.arn
}

output "master_username" {
  value = aws_db_instance.this.username
}

output "arn" {
  value = aws_db_instance.this.arn
}

output "endpoint" {
  value = aws_db_instance.this.endpoint
}
