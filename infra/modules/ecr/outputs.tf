output "api_repository_url" {
  description = "The URL of the api image repository."
  value       = aws_ecr_repository.repository.repository_url
}
