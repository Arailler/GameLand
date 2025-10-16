resource "aws_launch_template" "this" {
  name_prefix            = var.name_prefix
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile {
    name = var.instance_profile
  }

  tags = merge(
    var.tags,
    { Terraform = "true" }
  )
}
