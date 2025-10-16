resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for idx, arn in var.attached_policy_arns : idx => arn }
  role       = var.role_name
  policy_arn = each.value
}