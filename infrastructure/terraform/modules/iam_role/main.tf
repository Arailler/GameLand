resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = var.assume_role_policy_json
  description        = var.description
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for idx, arn in var.attached_policy_arns : idx => arn }
  role       = aws_iam_role.this.name
  policy_arn = each.value
}
