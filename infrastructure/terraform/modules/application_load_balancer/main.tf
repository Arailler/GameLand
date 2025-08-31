resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids
  tags               = merge(var.tags, { Name = var.name, Terraform = "true" })
}

resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = var.target_protocol
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
  tags = merge(var.tags, { Terraform = "true" })
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.target_port
  protocol          = var.target_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
  tags = merge(
    var.tags, { Name = var.name, Terraform = "true" }
  )
}