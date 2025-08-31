resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  tags = merge(
    var.tags, { Name = "${var.name_prefix}-${count.index + 1}", Terraform = "true" }
  )
}