# ECS Fargate Cluster
module "ecs_cluster" {
  source = "./modules/ecs-cluster"
  name   = var.ecs_cluster_name
}


# RDS Database
module "rds" {
  source = "./modules/rds"

  name       = var.name
  vpc_id     = var.vpc_id
  subnet_ids = var.database_subnet_ids

  instance_class        = var.database_instance_class
  allocated_storage     = var.database_allocated_storage
  max_allocated_storage = var.database_max_allocated_storage
  engine_version        = var.database_engine_version
  multi_az              = var.database_multi_az
}


# Elasticache Redis
module "elasticache" {
  source = "./modules/elasticache"

  name       = var.elasticache_name
  vpc_id     = var.vpc_id
  subnet_ids = var.elasticache_subnet_ids
  node_type  = var.elasticache_node_type
}


# S3 Bucket
module "s3_bucket" {
  source = "./modules/s3"
  name   = var.bucket_name
}


# Application Load Balancer
module "alb" {
  source = "./modules/alb"
}


# ECS Fargate Service (Frontend, Backend, Minio. Exporter)
module "ecs_service" {
  source = "./modules/ecs-service"
}
