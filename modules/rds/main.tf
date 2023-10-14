resource "random_password" "this" {
  length           = 32
  special          = true
  override_special = "_%@"
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_parameter_group" "this" {
  name_prefix = "${var.name}-db-"
  family      = "postgres${split(".", var.engine_version)[0]}"
}

resource "aws_db_instance" "this" {
  identifier_prefix = "${var.name}-db-"
  db_name           = "penpot"
  engine            = "postgres"
  engine_version    = var.engine_version
  instance_class    = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_subnet_group_name = aws_db_subnet_group.this.name
  parameter_group_name = aws_db_parameter_group.this.name

  username = "penpot"
  password = random_password.this.result
}

resource "aws_secretsmanager_secret" "this" {
  name                    = "${aws_db_instance.this.id}-credentials"
  description             = "Master user credentials for ${aws_db_instance.this.id}"
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username = aws_db_instance.this.username
    password = aws_db_instance.this.password
  })
}

resource "aws_security_group" "this" {
  name_prefix = "${var.name}-db-"
  description = "Security group for ${var.name}-db"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.consumer.id
  security_group_id        = aws_security_group.this.id
}

resource "aws_security_group" "consumer" {
  name_prefix = "${var.name}-db-consumer-"
  description = "Security group for ${var.name}-db-consumer"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "consumer" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.this.id
  security_group_id        = aws_security_group.consumer.id
}
