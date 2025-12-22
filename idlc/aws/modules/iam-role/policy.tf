resource "aws_iam_role_policy" "inline" {
  count = var.inline_policy != null ? 1 : 0

  role   = aws_iam_role.this.id
  policy = var.inline_policy
}

resource "aws_iam_role_policy_attachment" "managed" {
  count = length(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = var.managed_policy_arns[count.index]
}