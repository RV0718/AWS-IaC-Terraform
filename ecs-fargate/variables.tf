# This is the variable definition file. Define all the Env variables here

variable "vpc_cidr" {
  description = "Choose cidr for vpc"
  type        = string
  default     = "172.16.0.0/16"
}

variable "region" {
  description = "Choose region for your stack"
  type        = string
  default     = "eu-west-1"
}

variable "name" {
  description = "Choose region for your stack"
  type        = string
  default     = "my"
}

variable "environment" {
  description = "Choose region for your stack"
  type        = string
  default     = "dev"
}

variable "container_port" {
  description = "Port of container"
  default     = 80
}

variable "container_name" {
  description = "Name of the container"
  default     = "nginx"
}

variable "image_tag" {
  description = "Image tag"
  default     = "latest"
}

variable "task_definition_cpu" {
  description = "The number of cpu units used by the task"
  default     = "256"
}

variable "task_definition_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = "512"
}


variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = "256"
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = "512"
}

variable "container_image" {
  description = "Docker image to be launched"
  default     = "rv0718/spring-redis"
}

variable "service_desired_count" {
  description = "Number of services running in parallel"
  default     = "1"
}

variable "target_min_capacity" {
  description = "Min number of services running in parallel"
  default     = "1"
}

variable "target_max_capacity" {
  description = "Max number of services running in parallel"
  default     = "3"
}
