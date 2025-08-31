resource "aws_eip" "this" {
  count  = var.elastic_ip_count
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name      = "${var.name_prefix}-${count.index + 1}"
      Terraform = "true"
    }
  )
}
