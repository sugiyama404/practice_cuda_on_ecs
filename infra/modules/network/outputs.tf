output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "sg_alb_id" {
  value = aws_security_group.alb_sg.id
}

output "sg_ecs_id" {
  value = aws_security_group.ecs_sg.id
}

output "subnet_public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "subnet_public_subnet_1c_id" {
  value = aws_subnet.public_subnet_1c.id
}

output "subnet_private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}
