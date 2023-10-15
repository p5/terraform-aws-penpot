resource "random_password" "this" {
  length  = 16
  special = true
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = var.name
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.this.name
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids = [
    aws_security_group.this.id,
  ]
}

resource "aws_elasticache_parameter_group" "this" {
  name        = var.name
  family      = "redis7"
  description = "Parameter group for ${var.name}"
}

resource "aws_elasticache_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_user" "this" {
  user_id       = "penpot"
  user_name     = "penpot"
  access_string = "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"
  engine        = "REDIS"
  passwords     = [random_password.this.result]
}

resource "aws_elasticache_user_group" "this" {
  engine        = "REDIS"
  user_group_id = "penpot"
  user_ids = [
    "default",
    aws_elasticache_user.this.user_id,
  ]
}

resource "aws_secretsmanager_secret" "this" {
  name_prefix             = "${aws_elasticache_cluster.this.id}-credentials-"
  description             = "Master user credentials for ${aws_elasticache_cluster.this.id}"
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username  = aws_elasticache_user.this.user_name
    passwords = aws_elasticache_user.this.passwords
  })
}

resource "aws_security_group" "this" {
  name_prefix = "${var.name}-elasticache-"
  description = "Security group for ${var.name}-elasticache"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.consumer.id
  security_group_id        = aws_security_group.this.id
}

resource "aws_security_group" "consumer" {
  name_prefix = "${var.name}-consumer-"
  description = "Security group for ${var.name}-consumer"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "consumer" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.this.id
  security_group_id        = aws_security_group.consumer.id
}
