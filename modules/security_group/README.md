# Security Group Module

This module creates the security group for the Minecraft server, managing inbound and outbound traffic rules.

## Resources Created

| Resource | Name | Description |
|----------|------|-------------|
| `aws_security_group` | `minecraft-sg` | Security group with Minecraft and SSH rules |
| `data.http` | `my_ip` | Fetches my ip |

## Security Rules

| Type | Protocol | Port | Source | Purpose |
|------|----------|------|--------|---------|
| Ingress | TCP | 25565 | `0.0.0.0/0` | Minecraft game traffic |
| Ingress | TCP | 22 | My public IP `/32` | SSH access |
| Egress | All | All | `0.0.0.0/0` | Outbound internet access |

## Input Variables

| Name | Description |
|------|-------------|
| `vpc_id` | VPC ID to create the security group in | 

## Outputs

| Name | Description |
|------|-------------|
| `aws_security_group_id` | ID of the created security group |
