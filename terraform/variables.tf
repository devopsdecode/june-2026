variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application name used for resource naming"
  type        = string
  default     = "fintech-job-portal"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "container_image" {
  description = "Docker image repository and tag"
  type        = string
  default     = "rajnadar/fintech-job-portal:latest"
}

variable "container_port" {
  description = "Container port exposed by the application"
  type        = number
  default     = 8080
}

variable "app_count" {
  description = "Number of ECS tasks to run in parallel"
  type        = number
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate task CPU units (256, 512, 1024, etc.)"
  type        = string
  default     = "512"
}

variable "fargate_memory" {
  description = "Fargate task memory in MB (1024, 2048, etc.)"
  type        = string
  default     = "1024"
}
