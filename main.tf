variable "name" {
  type        = string
  description = "The name of the PenPot instance"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to use"
}

variable "database_subnet_ids" {
  type        = list(string)
  description = "The subnet IDs to use for the database"
}

variable "database_instance_class" {
  type        = string
  description = "The instance class to use for the database"
  default     = null
}

variable "database_max_allocated_storage" {
  type        = number
  description = "The maximum allocated storage in gigabytes for the database"
  default     = null
}

variable "database_engine_version" {
  type        = string
  description = "The engine version to use for the database"
  default     = null
}

# ECS Fargate Cluster
module "ecs_cluster" {
  source = "./modules/ecs-cluster"
}


# RDS Database
module "rds" {
  source = "./modules/rds"

  name       = var.name
  vpc_id     = var.vpc_id
  subnet_ids = var.database_subnet_ids

  instance_class        = var.database_instance_class
  max_allocated_storage = var.database_max_allocated_storage
  engine_version        = var.database_engine_version
}


# Elasticache Redis
module "redis" {
  source = "./modules/elasticache"
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
