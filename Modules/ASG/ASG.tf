variable "instance-sg" {}
variable "AMIS" {}
variable "key_name" {}
variable "sub1" {}
variable "sub2" {}
resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = var.AMIS
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = ["${var.instance-sg}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 5
    encrypted   = true
  }
  user_data = <<-EOF
                 #!/bin/bash
                 yum update -y
                 yum install httpd -y
                 service httpd start
                 chkconfig httpd on
                 cd /var/www/html
                 echo "<html><h1>Welcome!</h1></html>" > index.html
                EOF
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = ["${var.sub1}", "${var.sub2}"]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.my-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

