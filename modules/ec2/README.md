# EC2 Module

This module creates the EC2 instance that runs the Minecraft server using the `itzg/minecraft-server` Docker image.

## Resources Created

| Resource | Description |
|----------|-------------|
| `aws_instance`  | EC2 instance with user data script for Docker & Minecraft setup |
| `aws_key_pair`  | Key pair from local public key (`~/.ssh/minecraft-key.pub`) |
| `aws_eip`    | Elastic IP for a persistent public address |
| `aws_eip_association`   | Associates the Elastic IP with the instance |

## Input Variables

| Name | Description |
|------|-------------|
| `ami_id` | AMI ID for the EC2 instance |
| `instance_type` | Instance type |
| `subnet_id` | Subnet ID to launch the instance in |
| `security_group_ids` | List of security group IDs to attach |
| `iam_instance_profile` | IAM instance profile name for S3 access |
| `server_start_script` | User data script content for server setup |

## Outputs

| Name | Description |
|------|-------------|
| `instance_id` | ID of the EC2 instance |
| `public_ip` | Public IP of the instance |
| `instance_arn` | ARN of the EC2 instance |
