resource "aws_key_pair" "keypair" {
  key_name   = "${var.app_name}-keypair"
  public_key = file("./modules/ec2/src/keypair.pub")

  tags = {
    Name = "${var.app_name}-keypair"
  }
}

resource "aws_instance" "ecs_gpu_instance" {
  ami                    = data.aws_ami.app.id
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
echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
echo ECS_ENABLE_GPU_SUPPORT=true >> /etc/ecs/ecs.config

# GPUドライバーの確認と初期化
/usr/bin/nvidia-smi

# ECSエージェントを再起動して新しい設定を適用
systemctl restart ecs
EOF

  instance_market_options {
    market_type = "spot"

    spot_options {
      instance_interruption_behavior = "terminate"
      spot_instance_type             = "one-time"
    }
  }

  tags = {
    Name = "gpu-ecs-instance"
  }
}
