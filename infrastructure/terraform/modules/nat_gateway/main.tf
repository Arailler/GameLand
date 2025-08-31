resource "aws_nat_gateway" "this" {
  count = length(var.subnet_ids)

  allocation_id = var.allocation_ids[count.index]
  subnet_id     = var.subnet_ids[count.index]

  tags = merge(
    var.tags,
    {
      Name      = "${var.name_prefix}-${count.index + 1}"
      Terraform = "true"
    }
  )
}
