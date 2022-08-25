# Configuracoes gerais do Application Load Balancer - Listener, Target Group e Attachment
resource "aws_alb" "orion-alb" {
  name               = "orion-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.orion-subnet-public-1.id, aws_subnet.orion-subnet-public-2.id]
  security_groups    = [aws_security_group.alb-securitygroup-web.id]
}

# Listeners
resource "aws_alb_listener" "frontend-orion-listeners" {
  load_balancer_arn = aws_alb.orion-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
   target_group_arn = aws_alb_target_group.frontend-orion-target-group.arn
   type             = "forward"
  }
}

# Target Group
resource "aws_alb_target_group" "frontend-orion-target-group" {
  name     = "frontend-orion-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.orion-vpc.id

  health_check {
   path                = "/"
   healthy_threshold   = 2
   unhealthy_threshold = 2
   timeout             = 3
   interval            = 30
   matcher             = "200"
  }
}
