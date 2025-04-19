resource "aws_autoscaling_group" "ecs_asg" {
  name                = "ecs-asg"
  vpc_zone_identifier = [var.public_subnet_1a_id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }
}


resource "aws_launch_template" "ecs_launch_template" {
  name_prefix   = "ecs-launch-template-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    security_groups = [var.sg_ecs_id]
  }

  key_name = aws_key_pair.keypair.key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=chatbot-cluster >> /etc/ecs/ecs.config
  EOF
  )
}
