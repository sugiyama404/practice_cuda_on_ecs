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
set -euo pipefail

echo "===== Setting up ECS cluster and GPU support ====="
cat <<EOT > /etc/ecs/ecs.config
ECS_CLUSTER=${var.ecs_cluster_name}
ECS_ENABLE_GPU_SUPPORT=true
EOT

echo "===== Restarting ECS agent ====="
if systemctl list-units --type=service | grep -q "ecs"; then
  systemctl restart ecs
elif [ -f /etc/init/ecs.conf ]; then
  service ecs restart
else
  stop ecs || true
  start ecs
fi

echo "===== Verifying GPU availability ====="
if command -v nvidia-smi >/dev/null 2>&1; then
  nvidia-smi
else
  echo "nvidia-smi not found. Is the NVIDIA driver installed correctly?"
fi
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
