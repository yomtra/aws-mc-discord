# S3 Module

This module provisions an S3 bucket to store mods for the server.

## Resources Created

| Resource | Name | Description |
|----------|------|-------------|
| `aws_s3_bucket` | `mc-mods-bucket` | S3 bucket for storing the modpack archive |
| `aws_s3_object` | `mods/modpack.zip` | Uploads the local modpack zip to the bucket |

## Input Variables

| Name | Description |
|------|-------------|
| `mc_bucket` | Bucket name |
| `mods` | Local path to the modpack zip file |

## Outputs

| Name | Description |
|------|-------------|
| `bucket_name` | Name of the S3 bucket |