resource "aws_ecr_repository" "repository" {
  name                 = var.image_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.app_name}-repository"
  }
}
