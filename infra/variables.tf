variable "app_name" {
  description = "application name"
  type        = string
  default     = "chatbot"
}

variable "image_name" {
  description = "Docker image name"
  type        = string
  default     = "chatbot"
}

variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-northeast-1"
}
