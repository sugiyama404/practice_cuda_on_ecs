resource "aws_key_pair" "keypair" {
  key_name   = "${var.app_name}-keypair"
  public_key = file("./modules/ec2/src/keypair.pub")

  tags = {
    Name = "${var.app_name}-keypair"
  }
}

# EC2インスタンス（aws_autoscaling_groupの代わりにaws_instanceを使用）
resource "aws_instance" "ecs_gpu_instance" {
  ami                    = data.aws_ami.dlami_pytorch.id
  instance_type          = "g4dn.xlarge"
  subnet_id              = var.public_subnet_1a_id
  vpc_security_group_ids = [var.sg_ecs_id]
  iam_instance_profile   = var.instance_profile_name
  key_name               = aws_key_pair.keypair.key_name

  root_block_device {
    volume_size           = 100
    volume_type           = "gp3"
    delete_on_termination = true
  }

  user_data = <<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.gpu_cluster.name} >> /etc/ecs/ecs.config
    echo ECS_ENABLE_GPU_SUPPORT=true >> /etc/ecs/ecs.config
  EOF

  tags = {
    Name = "gpu-ecs-instance"
  }
}
