resource "aws_autoscaling_group" "ecs_gpu_asg" {
  name                      = "ecs-gpu-asg"
  desired_capacity          = 1
  max_size                  = 1
  min_size                  = 1
  vpc_zone_identifier       = [var.public_subnet_1a_id]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.ecs_gpu_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "gpu-ecs-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.app_name}-keypair"
  public_key = file("./modules/ec2/src/keypair.pub")

  tags = {
    Name = "${var.app_name}-keypair"
  }
}
