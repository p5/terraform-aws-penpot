variable "name" {
  type        = string
  description = "The name of the ECS cluster"
}

variable "container_insights_enabled" {
  type        = bool
  description = "Whether to enable container insights"
  default     = true
}
