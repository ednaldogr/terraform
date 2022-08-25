## Listeners Rules - Exemplo
#resource "aws_alb_listener_rule" "static-orion-rule" {
#  listener_arn = "aws_alb_listener.frontend-orion-listeners.arn"
#  priority     = 100
#
#  action {
#   type             = "forward"
#   target_group_arn = "aws_alb_target_group.static-orion-target-group.arn"
#  }
#
#  condition {
#   field  = "path-pattern"
#   values = ["/static/*"]
#  }
#}
#
## Target Group
#resource "aws_alb_target_group" "static-orion-target-group" {
#  name     = "static-orion-target-group"
#  port     = 80
#  protocol = "HTTP"
#  vpc_id   = aws_vpc.main.id
#}
#
## Associando instancias ao Target Group
#resource "aws_alb_target_group_attachment" "static-orion-attachment-1" {
#  target_group_arn = "aws_alb_target_group.static-orion-target-group.arn"
#  target_id        = "aws_instance.orion-static.id"
#  port             = 80
#}
