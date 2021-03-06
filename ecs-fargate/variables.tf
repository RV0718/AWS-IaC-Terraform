# This is the variable definition file

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
  default     = 8080
}

variable "container_name" {
  description = "Port of container"
  default     = "spring-redis"
}

variable "image_tag" {
  description = "Port of container"
  default     = "1.0.0-SNAPSHOT"
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = "1024"
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = "2048"
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