# VPC Module

This module sets up the VPC and networking for the Minecraft server, including a public subnet, internet gateway, and routing.

## Resources Created

| Resource | Name | Description |
|----------|------|-------------|
| `aws_vpc` | `minecraft-vpc` | VPC with DNS hostnames and DNS support enabled |
| `aws_subnet` | `minecraft-public-subnet` | Public subnet with auto-assign public IP |
| `aws_internet_gateway` | `minecraft-igw` | Internet Gateway for external access |
| `aws_route_table` | `minecraft-public-route-table` | Route table with default route to IGW |
| `aws_route_table_association` |  | Associates the public subnet to the route table |

## Input Variables

| Name | Description |
|------|-------------|
| `name` | VPC name tag |
| `cidr` | CIDR block for the VPC | 
| `public_subnet_cidr` | CIDR block for the public subnet |
| `aws_az` | Availability zone for the subnet |

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | ID of the created VPC |
| `aws_subnet` | ID of the created public subnet |
