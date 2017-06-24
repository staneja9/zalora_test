variable "region" {
  description = "AWS region to deploy "
}

variable "vpc_cidr" {
  description = "vpc_cidr"
}


variable "public_subnetA_name" {
   description = "Public subnetA name"
}

variable "public_subnetA_cidr" {
   description = "Public SubnetA cidr"
}

variable "availability_zoneA" {
   description = "Public SubnetA AZ"
}

variable "availability_zoneB" {
   description = "Public SubnetB AZ"
}

variable "public_subnetB_name" {
   description = "Public subnetB name"
}

variable "public_subnetB_cidr" {
   description = "Public SubnetB cidr"
}

variable "public_route_table_name" {
   description = "Public route table  name"

}

variable "vpc_name" {
   description = "Name of VPC"

}

variable "private_subnetA_cidr" {
   description = "CIDR range of priavte subnet A"

}

variable "private_subnetA_name" {
   description = "Private subnet A name"

}

variable "private_rt_name" {
   description = "Public route table name"

}

variable "private_subnetB_cidr" {
   description = "Private subnet B CIDR"

}


variable "private_subnetB_name" {
   description = "Name of private subnet B"

}
