variable "name" {
  type        = string
  description = "The name of the Elasticache cluster"
}

variable "node_type" {
  type        = string
  description = "The node type to be used"
  default     = "cache.t4g.micro"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to be used"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs to be used"
}

variable "engine_version" {
  type        = string
  description = "The engine version to use for the memcached cluster"
  default     = "1.6"
}
