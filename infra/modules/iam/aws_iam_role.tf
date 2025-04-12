# LambdaのIAMロール
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecsInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          type = "Service"
          identifiers = [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}

