resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags {
        Name = "${var.vpc_name}"
    }
}

resource "aws_internet_gateway" "ig" {
    vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_eip" "nat_eip" {
    vpc = true
}



/*
  Public Subnet Zone A
*/
resource "aws_subnet" "public_subnetA" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "${var.public_subnetA_cidr}"
    availability_zone = "${var.availability_zoneA}"

    tags {
        Name = "${var.public_subnetA_name}"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.ig.id}"
    }

    tags {
        Name = "${var.public_route_table_name}"
    }
}

resource "aws_route_table_association" "public_rta" {
    subnet_id = "${aws_subnet.public_subnetA.id}"
    route_table_id = "${aws_route_table.public_rt.id}"
}


/*
  Public Subnet Zone B
*/
resource "aws_subnet" "public_subnetB" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "${var.public_subnetB_cidr}"
    availability_zone = "${var.availability_zoneB}"

    tags {
        Name = "${var.public_subnetB_name}"
    }
}


resource "aws_route_table_association" "public_rtb" {
    subnet_id = "${aws_subnet.public_subnetB.id}"
    route_table_id = "${aws_route_table.public_rt.id}"
}

/*
 Nat gateway
*/

resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.nat_eip.id}"
    subnet_id = "${aws_subnet.public_subnetA.id}"

    depends_on = ["aws_internet_gateway.ig"]
}


/*
  Private Subnet Zone A
*/
resource "aws_subnet" "private_subnetA" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "${var.private_subnetA_cidr}"
    availability_zone = "${var.availability_zoneA}"

    tags {
        Name = "${var.private_subnetA_name}"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat.id}"
    }

    tags {
        Name = "${var.private_rt_name}"
    }
}

resource "aws_route_table_association" "private_rta_subnetA" {
    subnet_id = "${aws_subnet.private_subnetA.id}"
    route_table_id = "${aws_route_table.private_rt.id}"
}

/*
  Private Subnet Zone B
*/
resource "aws_subnet" "private_subnetB" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "${var.private_subnetB_cidr}"
    availability_zone = "${var.availability_zoneB}"

    tags {
        Name = "${var.private_subnetB_name}"
    }
}


resource "aws_route_table_association" "private_rta_cubnetB" {
    subnet_id = "${aws_subnet.private_subnetB.id}"
    route_table_id = "${aws_route_table.private_rt.id}"
}
