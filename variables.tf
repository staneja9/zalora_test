variable "region" {
  description = "AWS region to deploy"
}

variable "access_key" {
  description = "Programatic Access Keys"
}

variable "secret_key" {
  description = "Programatic Secret Access Keys"
}

variable "availability_zoneA" {
   description = "availibility zone for zone A"
}

variable "availability_zoneB" {
   description = "availibility zone for zone B"
}


variable "public_subnetA_cidr" {
   description = "Public cidr for zone A"
}

variable "public_subnetB_cidr" {
   description = "Public cidr for zone B"
}

variable "private_rt_name" {
  description = "private subnet route table"
}

variable "vpc_name" {
  description = "vpc name"
}

variable "vpc_cidr" {
  description = "CIDR vpc"
}

variable "private_subnetA_name" {
  description = "private_subnetA_name"
}

variable "private_subnetA_cidr" {
  description = "private_subnetA_cidr"
}

variable "private_subnetB_name" {
  description = "private_subnetB_name"
}

variable "private_subnetB_cidr" {
  description = "private_subnetB_cidr"
}

variable "public_subnetA_name" {
  description = "public_subnetA_name"
}

variable "public_subnetB_name" {
  description = "public_subnetB_name"
}

variable "public_route_table_name" {
  description = "public_route_table_name"
}


variable "environment" {
  description = "Environment Name like staging/prod or company name if only environment"
}

variable "instance_type" {
   description = "instance type of EC2 instance"
}
