#.................................................................
# User data template that specifies how to bootstrap each instance
#..................................................................
data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.tpl")}"

}

data "aws_ami" "amzn_linux" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-2016.09.1.20161221-x86_64-gp2*"]
  }
  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }
  #  owners = [""] #
}


#.................................................................
# Creating ssh key-pair to connect to ec2-instance
#..................................................................

resource "aws_key_pair" "zalora" {
  key_name   = "zalora-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAq9SwsedK7poPhcWWmdIKPrSvBrZ8MriLjFw6V5II0Y7MlQHXhLZsG507s4JzXzlSzCx58vmU85ODd1Coo1CMDCk5VITYjUf2nSoBWHDKzMhy8uyDy7mVG87yxkDr1kPm6d2P27daI2tPaSWbvpWQ/jY8wrxH57253us1NfalH8L8VnRkrB+dOuUc+FmV/1dRMlslOgjZ93Aehh/i+TUf5RONOw6N2fFNII+U+/sVKEQeSoJhfQXMvdQM/0KDyTGSRt/Kz/u2AlIN3QWGB+zlbYz3gkgCrR+LR1UB6KYlBofP3n30rY8I1sgvS7SLg/HRJ5XCGd38a0fNlFb8b0mqyQ== rsa-key-20170624"
}


#............................................................................
# The launch configuration for EC2 instance to be attached behind Load Balancer
#............................................................................

resource "aws_launch_configuration" "ec2" {
  name_prefix = "${var.environment}-app"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.zalora.key_name}"
  associate_public_ip_address = "true"
  security_groups = ["${var.security_group_ec2_instance_id}"]
  image_id = "${data.aws_ami.amzn_linux.id}"
  user_data = "${data.template_file.user_data.rendered}"
  root_block_device {
      volume_type = "gp2"
      volume_size = "200"
    }

  lifecycle { create_before_destroy = true }
}


#......................................................................................................
# The auto scaling group that specifies how we want to scale the number of EC2 Instances
#......................................................................................................

resource "aws_autoscaling_group" "zalora" {
  name = "${var.environment}"
  min_size = "${var.asg_min}"
  max_size = "${var.asg_max}"
  desired_capacity = "${var.desired}"
  launch_configuration = "${aws_launch_configuration.ec2.name}"
  vpc_zone_identifier = ["${split(",", var.public_subnet_ids)}"]
  health_check_type = "EC2"

  lifecycle { create_before_destroy = true }
  load_balancers = ["${var.elb_id}"]

  tag {
    key = "Name"
    value = "${var.environment}-auto-scaling-group"
    propagate_at_launch = true
  }
}


#...........................................................................
# The Autoscaing Group Policy
#...........................................................................

resource "aws_autoscaling_policy" "scale_up" {
  name = "${var.environment}-instances-scale-up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.zalora.name}"
}

resource "aws_autoscaling_policy" "alfresco_scale_down" {
  name = "${var.environment}-instances-scale-down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.zalora.name}"
}

#......................................................................................
# A CloudWatch alarm that monitors CPU utilization of the instances for scaling up
#......................................................................................

resource "aws_cloudwatch_metric_alarm" "instances_cpu_high" {
  alarm_name = "${var.environment}-instances-CPU-Utilization-Above-30"
  alarm_description = "This alarm monitors the instances CPU utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Average"
  threshold = "30"
  alarm_actions = ["${aws_autoscaling_policy.scale_up.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.zalora.name}"
  }
}
