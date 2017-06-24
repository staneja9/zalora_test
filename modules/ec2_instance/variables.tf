variable "instance_type" {
  description = "Instance type of each EC2 instance in the ECS cluster"
}


variable "security_group_ec2_instance_id" {
  description = "Id of security group allowing internal traffic from load balancer"
}

variable "asg_min" {
  description = "Minimum number of EC2 instances to run in the ECS cluster"
  default = 2
}

variable "asg_max" {
  description = "Maximum number of EC2 instances to run in the ECS cluster"
  default = 3
}

variable "desired" {
  description = "Desired number of EC2 instances to run in the ECS cluster"
  default = 2
}

variable "public_subnet_ids" {
  description = "Comma-separated list of subnets where EC2 instances should be deployed"
}

variable "environment" {
  description = "environment name or the application name"
}

variable "elb_id" {
  description = " ELB ID of DCS instance"
}

