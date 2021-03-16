provider "aws" {
  region = var.region
}

#terraform {
#    backend "s3" {
#        bucket = "mine-ecs-ec2-cluster-tf-state"
#        key    = "state.tfstate"
#    }
#}
