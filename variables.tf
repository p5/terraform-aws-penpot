variable "ecs_cluster_name" {
  type        = string
  description = "The name of the ECS cluster"
}

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
  default     = "db.t4g.small"
}

variable "database_allocated_storage" {
  type        = number
  description = "The allocated storage in gigabytes for the database"
  default     = 20
}

variable "database_max_allocated_storage" {
  type        = number
  description = "The maximum allocated storage in gigabytes for the database"
  default     = 100
}

variable "database_engine_version" {
  type        = string
  description = "The engine version to use for the database"
  default     = 15
  validation {
    error_message = "The engine version must not include minor versions"
    condition     = can(regex("^\\d+$", var.database_engine_version))
  }
}

variable "database_multi_az" {
  type        = bool
  description = "Whether to use multiple availability zones for the database"
  default     = true
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "elasticache_name" {
  type        = string
  description = "The name of the Elasticache cluster"
}

variable "elasticache_subnet_ids" {
  type        = list(string)
  description = "The subnet IDs to be used"
}

variable "elasticache_node_type" {
  type        = string
  description = "The node type to be used"
  default     = "cache.t4g.micro"
}
