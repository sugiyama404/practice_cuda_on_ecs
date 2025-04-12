# SecurityGroup for ecs
resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-ecs-sg"
  }
}
