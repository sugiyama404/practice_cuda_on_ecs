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
  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.capability.gpu == true"
  }
  # depends_on = [time_sleep.wait_50_minutes]
}

# resource "time_sleep" "wait_50_minutes" {
#   create_duration = "50m"
# }
