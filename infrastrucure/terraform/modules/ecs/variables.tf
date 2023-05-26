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

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "Subnets"
  type        = list
}

variable "security_groups" {
  description = "security_groups"
  type        = list
}