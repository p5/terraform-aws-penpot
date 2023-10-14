variable "name" {
  type        = string
  description = "The name of the RDS instance"
}

variable "allocated_storage" {
  type        = number
  description = "The allocated storage in gigabytes"
  default     = 20
}

variable "max_allocated_storage" {
  type        = number
  description = "The maximum allocated storage in gigabytes"
  default     = 100
}

variable "engine_version" {
  type        = string
  description = "The engine version to use"
  default     = 15
}

variable "instance_class" {
  type        = string
  description = "The instance class to use"
  default     = "db.t4g.small"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs to use"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to use"
}

variable "multi_az" {
  type        = bool
  description = "Whether to use multiple availability zones"
  default     = true
}
