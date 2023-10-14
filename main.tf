# ECS Fargate Cluster
module "ecs_cluster" {
  source = "./modules/ecs-cluster"
}


# RDS Database
module "rds" {
  source = "./modules/rds"
}


# Elasticache Redis
module "redis" {
  source = "./modules/redis"
}


# S3 Bucket
module "s3" {
  source = "./modules/s3"
}


# Application Load Balancer
module "alb" {
  source = "./modules/alb"
}


# ECS Fargate Service (Frontend, Backend, Minio. Exporter)
module "ecs_service" {
  source = "./modules/ecs-service"
}
