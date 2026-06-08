variable "ami_id" {
	type        = string
	description = "AMI ID for the Minecraft server instance"
}

variable "instance_type" {
	type        = string
	description = "EC2 instance type for the Minecraft server"
}

variable "subnet_id" {
	type        = string
	description = "Subnet ID for the Minecraft server instance"
}

variable "security_group_ids" {
	type        = list(string)
	description = "List of security group IDs for the Minecraft server instance"
}

variable "iam_instance_profile" {
  type = string
  description = "IAM instance profile for the Minecraft server instance"
}

variable "server_start_script" {
  type = string
  description = "User data script to start the Minecraft server"
}