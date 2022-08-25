# scale up alarm

resource "aws_autoscaling_policy" "orion-cpu-policy" {
  name                   = "orion-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.orion-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "orion-cpu-alarm" {
  alarm_name          = "orion-cpu-alarm"
  alarm_description   = "Alarme baseado no uso da CPU para o cluster Orion"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.orion-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.orion-cpu-policy.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "orion-cpu-policy-scaledown" {
  name                   = "orion-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.orion-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "orion-cpu-alarm-scaledown" {
  alarm_name          = "orion-cpu-alarm-scaledown"
  alarm_description   = "Volta ao uso normal de CPU"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.orion-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.orion-cpu-policy-scaledown.arn]
}

