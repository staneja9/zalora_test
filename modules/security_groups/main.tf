#Security group for the Load Balancer

resource "aws_security_group" "load_balancer" {
  vpc_id = "${var.vpc_id}"
  name = "Load Balaner SG"
  description = "Will be attached with the Elastic Load Balancer"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Load Balaner SG"
  }
  lifecycle { create_before_destroy = true }
}


#Security group to be attached to the EC2 instances

resource "aws_security_group" "web_instance" {
  vpc_id = "${var.vpc_id}"
  name = "Web Instance SG"
  description = "Will be attached with the EC2 instance behind Load Balancer"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.load_balancer.id}"]
   }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.load_balancer.id}"]
   }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Web Instance SG"
  }
  lifecycle { create_before_destroy = true }
}
