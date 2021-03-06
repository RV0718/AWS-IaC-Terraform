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


# variable "web_ec2_count" {
#   description = "Choose number ec2 instances for web"
#   type        = string
#   default     = "2"
# }

# variable "nat_amis" {
#   type = map
#   default = {
#     us-east-1 = "ami-00a9d4a05375b2763"
#     us-east-2 = "ami-00d1f8201864cc10c"
#   }
# }
# variable "web_amis" {
#   type = "map"
#   default = {
#     us-east-1 = "ami-0b898040803850657"
#     us-east-2 = "ami-0d8f6eb4f641ef691"
#   }
# }

# variable "web_instance_type" {
#   description = "Choose instance type for your web"
#   type        = string
#   default     = "t2.micro"
# }

# variable "my_app_s3_bucket" {
#   default = "javahome-app-dev"
# }

# variable "web_tags" {
#   type = "map"
#   default = {
#     Name = "Webserver"
#   }
# }
