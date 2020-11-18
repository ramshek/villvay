resource "null_resource" "patience" {
    depends_on = [ aws_nat_gateway.nat_GW ]

    provisioner "local-exec" {
      command = "sleep 120"
    }
}


resource "aws_launch_configuration" "villvay-launchconfig" {
  name_prefix     = "villvay-launchconfig"
  image_id        = var.AMI_ID
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.vpc_SG.id]
  depends_on      = [ null_resource.patience ]
  iam_instance_profile = aws_iam_instance_profile.villvay_instance_profile.id
  user_data       = <<-EOF
  #cloud-boothook
  #! /bin/bash
  crontab -l > mycron
  echo "*/2 * * * * aws s3 sync s3://villvaybucket /root/s3" >> mycron
  crontab mycron  
  rm mycron
  mkdir /root/app
  cd /root
  mkdir villvay
  cd villvay
  git clone https://github.com/ramshek/springboot.git
  cd springboot
  mvn clean package
  cd target
  nohup java -jar hello-world-0.0.1-SNAPSHOT.jar > /tmp/log.txt 2>&1 &
  echo $! > /tmp/pid.file
  EOF
  }

resource "aws_autoscaling_group" "villvay-autoscaling" {
  name                      = "villvay-autoscaling"
  vpc_zone_identifier       = [aws_subnet.villvay_pvt_subnet.id]
  launch_configuration      = aws_launch_configuration.villvay-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  load_balancers            = [aws_elb.villvay-elb.name]
  force_delete              = true
  depends_on                = [aws_launch_configuration.villvay-launchconfig, aws_nat_gateway.nat_GW]

  tag {
    key                 = "Name"
    value               = "villvay-ec2"
    propagate_at_launch = true
  }
}


