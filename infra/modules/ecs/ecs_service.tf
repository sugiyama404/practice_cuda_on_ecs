# ECSサービス
resource "aws_ecs_service" "pytorch_gpu_service" {
  name            = "pytorch-gpu-service"
  cluster         = aws_ecs_cluster.gpu_cluster.id
  task_definition = aws_ecs_task_definition.pytorch_gpu_task.arn
  desired_count   = 1
  launch_type     = "EC2"
  deployment_controller {
    type = "ECS"
  }
}
