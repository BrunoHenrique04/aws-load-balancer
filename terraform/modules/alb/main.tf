# Module: Application Load Balancer and Target Group Attachments

resource "aws_lb_target_group" "ec2_lb_tg" {
  name     = "ec2-lb-tg"
  protocol = "HTTP"
  port     = 80
  vpc_id   = var.vpc_id
}

resource "aws_lb" "ec2_lb" {
  name               = "ec2-lb"
  load_balancer_type = "application"
  subnets            = [var.subnet_az1a_id, var.subnet_az1b_id]
  security_groups    = [var.security_group_id]
}

resource "aws_lb_listener" "ec2_lb_listener" {
  protocol          = "HTTP"
  port              = 80
  load_balancer_arn = aws_lb.ec2_lb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_lb_tg.arn
  }
}

# Attachments
resource "aws_lb_target_group_attachment" "ec2_lb_tg_instance_1a" {
  target_group_arn = aws_lb_target_group.ec2_lb_tg.arn
  target_id        = var.instance_1a_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_lb_tg_instance_1b" {
  target_group_arn = aws_lb_target_group.ec2_lb_tg.arn
  target_id        = var.instance_1b_id
  port             = 80
}

output "lb_dns_name" {
  value = aws_lb.ec2_lb.dns_name
}
