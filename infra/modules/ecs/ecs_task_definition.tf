# サンプルPyTorchタスク定義
resource "aws_ecs_task_definition" "pytorch_gpu_task" {
  family                   = "pytorch-gpu-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = var.ecs_instance_profile_arn
  task_role_arn            = var.ecs_instance_profile_arn

  container_definitions = jsonencode([
    {
      name      = "pytorch-gpu-container"
      image     = "${var.ai_repository_url}:latest"
      essential = true
      cpu       = 4096,
      memory    = 16384,

      resourceRequirements = [
        {
          type  = "GPU"
          value = "1"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/pytorch-gpu",
          awslogs-region        = "ap-northeast-1",
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
