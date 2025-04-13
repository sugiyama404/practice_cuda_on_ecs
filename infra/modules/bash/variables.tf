data "aws_caller_identity" "self" {}
variable "image_name" {}
variable "region" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
}
