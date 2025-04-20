resource "aws_cloudwatch_log_group" "ecs_log" {
  name              = "/ecs/pytorch-gpu"
  retention_in_days = 7
}
