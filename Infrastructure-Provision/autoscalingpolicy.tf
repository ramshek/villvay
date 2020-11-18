# scale up alarm

resource "aws_autoscaling_policy" "villvay-cpu-policy" {
  name                   = "villvay-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.villvay-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "villvay-cpu-alarm" {
  alarm_name          = "villvay-cpu-alarm"
  alarm_description   = "villvay-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.villvay-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.villvay-cpu-policy.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "villvay-cpu-policy-scaledown" {
  name                   = "villvay-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.villvay-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "villvay-cpu-alarm-scaledown" {
  alarm_name          = "villvay-cpu-alarm-scaledown"
  alarm_description   = "villvay-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.villvay-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.villvay-cpu-policy-scaledown.arn]
}

