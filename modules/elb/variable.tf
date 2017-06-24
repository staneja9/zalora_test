variable "public_subnet_ids" {
  description = "Comma-separated list of subnets where ELB should be deployed"
}

variable "security_group_lb_id" {
  description = "Id of security group allowing inbound traffic"
}

variable "environment" {
  description = "environment name"
}
