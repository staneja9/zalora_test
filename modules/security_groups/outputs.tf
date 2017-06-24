output "load_balancer" {
  value = "${aws_security_group.load_balancer.id}"
}

output "web_instance" {
  value = "${aws_security_group.web_instance.id}"
}
