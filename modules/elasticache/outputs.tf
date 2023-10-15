output "arn" {
  value = aws_elasticache_cluster.this.arn
}

output "endpoint" {
  value = aws_elasticache_cluster.this.cache_nodes.*.address
}

output "port" {
  value = aws_elasticache_cluster.this.cache_nodes.*.port
}

output "secret_arn" {
  value = aws_secretsmanager_secret.this.arn
}
