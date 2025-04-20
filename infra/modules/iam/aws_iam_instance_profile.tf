resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ecsInstanceProfile"
  role = aws_iam_role.ec2_instance_role.name
}
