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
  default     = "ecs-ec2"
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

variable "host_port" {
  description = "Port of container's host"
  default     = 80
}

variable "image_tag" {
  description = "Tag/Version of the image"
  default     = "latest"
}

variable "task_definition_cpu" {
  description = "The number of cpu units used by the task"
  default     = 128
}

variable "task_definition_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 256
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = 256
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 512
}

variable "container_image" {
  description = "Docker image to be launched"
  default     = "nginx"
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

variable "ec2_instance_type" {
  description = "Type of EC2 instance want to launched"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID to be used to create EC2 Instance"
  default     = "ami-0cdce788baec293cb"
}

variable "network_mode" {
  description = "The network mode to be used to ECS Task Definition"
  default     = "host"
}

variable "container_name" {
  description = "Container name to be provided"
  default     = "nginx"
}
