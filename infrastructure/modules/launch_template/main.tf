resource "aws_launch_template" "this" {
  name_prefix             = var.name_prefix
  image_id                = var.image_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  vpc_security_group_ids  = var.security_group_ids
  tag_specifications {
    resource_type = "instance"
    tags          = merge(var.tags, { Terraform = "true" })
  }
  tags = merge(
    var.tags, { Terraform = "true" }
  )
}