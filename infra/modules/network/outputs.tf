output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "sg_ecs_id" {
  value = aws_security_group.ecs_sg.id
}

output "public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}
