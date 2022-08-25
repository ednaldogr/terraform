resource "aws_autoscaling_group" "orion-autoscaling" {
  name                      = "orion-autoscaling"
  vpc_zone_identifier       = [aws_subnet.orion-subnet-public-1.id, aws_subnet.orion-subnet-public-2.id]
  launch_configuration      = aws_launch_configuration.orion-launchconfig.name
  min_size                  = 1
  desired_capacity          = 2
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  depends_on                = [aws_alb.orion-alb]
  target_group_arns         = [aws_alb_target_group.frontend-orion-target-group.arn]

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}


resource "aws_launch_configuration" "orion-launchconfig" {
  name_prefix     = "orion-launchconfig"
  image_id        = var.AMI_ID
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.allow-ssh.id, aws_security_group.alb-securitygroup-web.id]
  user_data       = "#!/bin/bash\nhostname=`hostname -f`\necho 'Hello World!!!'\necho 'O hostname da instancia e: '$hostname >> /var/www/html/index.nginx-debian.html" 
  lifecycle {
    create_before_destroy = true
  }
}

