resource "aws_launch_template" "ecs_gpu_launch_template" {
  name_prefix   = "ecs-gpu-"
  image_id      = data.aws_ami.app.id
  instance_type = "g4dn.xlarge"
  key_name      = aws_key_pair.keypair.key_name

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.sg_ecs_id]
    subnet_id                   = var.public_subnet_1a_id
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
set -euo pipefail

echo "===== Installing ecs-init (if missing) ====="
if ! rpm -q ecs-init >/dev/null 2>&1; then
  yum install -y ecs-init
fi

echo "===== Writing ECS config ====="
cat <<EOT > /etc/ecs/ecs.config
ECS_CLUSTER=chatbot-cluster
ECS_ENABLE_GPU_SUPPORT=true
EOT

echo "===== Enabling and starting ECS agent ====="
sudo systemctl stop ecs
sudo systemctl enable --now ecs
EOF
  )



  instance_market_options {
    market_type = "spot"

    spot_options {
      instance_interruption_behavior = "terminate"
      spot_instance_type             = "one-time"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "gpu-ecs-instance"
    }
  }
}
