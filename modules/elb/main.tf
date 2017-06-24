# Internet Facing Load Balancer

resource "aws_elb" "elb" {
  name = "${var.environment}-elb"
  security_groups = ["${var.security_group_lb_id}"]

  subnets = ["${split(",", var.public_subnet_ids)}"]
  idle_timeout = 300

  listener {
    instance_port = 80
    instance_protocol = "HTTP"
    lb_port = 80
    lb_protocol = "HTTP"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:22"
    interval = 30
  }


  tags {
    Name = "${var.environment}-elb"
  }
}
