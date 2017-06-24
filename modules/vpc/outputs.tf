output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "subnet_private_ids" {
  value = "${join(",", aws_subnet.private_subnetA.*.id, aws_subnet.private_subnetB.*.id)}"
}

output "subnet_public_ids" {
  value = "${join(",", aws_subnet.public_subnetA.*.id, aws_subnet.public_subnetB.*.id)}"
}


output "subnet_privateB_ids" {
  value = "${join(",", aws_subnet.private_subnetB.*.id)}"
}


output "subnet_privateA_ids" {
  value = "${join(",", aws_subnet.private_subnetA.*.id)}"
}

output "subnet_publicA_ids" {
  value = "${join(",", aws_subnet.public_subnetA.*.id)}"
}

output "subnet_publicB_ids" {
  value = "${join(",", aws_subnet.public_subnetB.*.id)}"
}
