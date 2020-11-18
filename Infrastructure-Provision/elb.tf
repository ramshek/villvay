resource "aws_elb" "villvay-elb" {
  name            = "villvay-elb"
  subnets         = [aws_subnet.villvay_pub_subnet.id]
  security_groups = [aws_security_group.elb-securitygroup.id]
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
    target              = "HTTP:80/hello"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 300
  tags = {
    Name = "my-elb"
  }
}
