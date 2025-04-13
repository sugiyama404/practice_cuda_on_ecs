resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  }

  provisioner "local-exec" {
    command = "docker build -t ${var.image_name} --file ../aiserver/Dockerfile ../aiserver/"
  }

  provisioner "local-exec" {
    command = "docker tag ${var.image_name}:latest ${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.image_name}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.image_name}:latest"
  }
}
