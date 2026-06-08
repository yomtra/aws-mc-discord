variable "minecraft_instance_id" {
  type        = string
}

variable "discord_public_key" {
  type        = string
  sensitive   = true
}

variable "allowed_role_ids" {
  type = string
}

variable "lambda_role_arn" {
  type        = string
}