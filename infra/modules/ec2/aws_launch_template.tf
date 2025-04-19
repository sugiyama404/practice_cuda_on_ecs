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

# ECSクラスター設定を作成
cat <<EOT > /etc/ecs/ecs.config
ECS_CLUSTER=chatbot-cluster
ECS_ENABLE_GPU_SUPPORT=true
EOT

# cloud-initの完了を待つためのマーカーファイルを作成
cat <<'EOT' > /usr/local/bin/start-ecs.sh
#!/bin/bash
# ECSサービスを再起動
systemctl stop ecs || true
systemctl enable ecs
systemctl start ecs
EOT

chmod +x /usr/local/bin/start-ecs.sh

# cloud-init完了後に実行するように設定
cat <<'EOT' > /etc/cloud/cloud.final.d/99-start-ecs.cfg
#cloud-config
runcmd:
  - [ /usr/local/bin/start-ecs.sh ]
EOT
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
