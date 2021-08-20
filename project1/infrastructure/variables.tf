variable "project_name_prefix" {
    description = "Name of the project"
    default = "ops-hire-project"
}

variable "aws_zone" {
    description = "The AWS zone to create things in."
    default = "us-east-1b"
}

variable "aws_az_count" {
    description = "Number of availability_zones to cover in the region"
    default = 2
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
}

variable "ecs_role" {
  description = "ECS role to allow access to the ECR repository"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8080
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

