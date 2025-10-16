resource "aws_autoscaling_attachment" "this" {
  count                  = length(var.autoscaling_group_names)
  autoscaling_group_name = var.autoscaling_group_names[count.index]
  lb_target_group_arn    = var.lb_target_group_arn
}
