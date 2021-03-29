resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = ["${var.pub1}", "${var.pub2}"]
  security_groups = ["${var.loadbalancer-sg}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}
variable "loadbalancer-sg" {}
variable "pub1" {}
variable "pub2" {}