variable "environment" {
  description = "The environment value for the script"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "ecs-cluster"
}

variable "task_name" {
  description = "ECS task definition name"
  type        = string
  default     = "task"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "container"
}

variable "docker_image" {
  description = "Docker image"
  type        = string
}

variable "service_name" {
  description = "ECS service"
  type        = string
  default     = "ecs-service"
}

variable "desired_count" {
  description = "Task number"
  type        = number
  default     = 1
}

variable "vpc_name" {
  description = "VPC NAME"
  type        = string
  default     = "custom"
}

