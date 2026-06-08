variable "name" {
    type = string
    default = "mc-vpc"
    description = "Name of the VPC"
}

variable "cidr" {
    type = string
    default = "10.0.0.0/16"
    description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
    type = string
    default =  "10.0.1.0/24" 
    description = "CIDR block for the public subnet"
}

variable "aws_az" {
  type = string
  default = "us-east-1a"
  description = "AWS Availability Zone for the VPC and its subnets"
}