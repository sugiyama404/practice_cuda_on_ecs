output "lambda_iam_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "sagemaker_iam_role_arn" {
  value = aws_iam_role.sagemaker_role.arn
}
