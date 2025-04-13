output "instance_profile_name" {
  value       = aws_iam_instance_profile.ecs_instance_profile.name
  description = "The name of the IAM instance profile."
}

output "ecs_instance_profile_arn" {
  value       = aws_iam_role.ecs_instance_role.arn
  description = "The ARN of the IAM role."
}
