# Configure the AWS Provider

provider "aws" {
  
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
  
}

module "vpc" {
  source = "./modules/vpc"

  region = "${var.region}"
  vpc_name = "${var.vpc_name}"
  vpc_cidr = "${var.vpc_cidr}"
  availability_zoneA = "${var.availability_zoneA}"
  availability_zoneB = "${var.availability_zoneB}"
  public_subnetA_name = "${var.public_subnetA_name}"
  public_subnetA_cidr = "${var.public_subnetA_cidr}"
  public_subnetB_name = "${var.public_subnetB_name}"
  public_subnetB_cidr = "${var.public_subnetB_cidr}"
  public_route_table_name = "${var.public_route_table_name}"
  private_subnetA_cidr = "${var.private_subnetA_cidr}"
  private_subnetA_name = "${var.private_subnetA_name}"
  private_rt_name = "${var.private_rt_name}"
  private_subnetB_cidr = "${var.private_subnetB_cidr}"
  private_subnetB_name = "${var.private_subnetB_name}"
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = "${module.vpc.vpc_id}"
}


module "elb" {
  source = "./modules/elb"

  public_subnet_ids = "${module.vpc.subnet_public_ids}"
  security_group_lb_id = "${module.security_groups.load_balancer}"
  environment = "${var.environment}"
}


module "ec2_instance" {
  source = "./modules/ec2_instance"

  instance_type = "${var.instance_type}"
  environment = "${var.environment}"
  security_group_ec2_instance_id = "${module.security_groups.web_instance}"
  public_subnet_ids = "${module.vpc.subnet_public_ids}"
  elb_id = "${module.elb.elb_id}"

}
