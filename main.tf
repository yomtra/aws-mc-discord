module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  ami_id                 = var.ami_id
	subnet_id              = module.vpc.subnet_id
	security_group_ids     = [module.security_group.aws_security_group_id]
	iam_instance_profile   = module.iam.instance_profile_name
  server_start_script    = file("${path.module}/scripts/start.sh") 
  instance_type = var.instance_type
  #ensures s3 bucket is created before instance is launched
  depends_on = [ module.s3]
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "s3" {
  source = "./modules/s3"
  mods = "${path.module}/mods/modpack.zip"
}

module "iam" {
    source = "./modules/iam"
    mc_bucket = module.s3.bucket_name
    instance_arn = module.ec2.instance_arn
}

module "lambda" {
  source = "./modules/lambda"
  minecraft_instance_id = module.ec2.instance_id
  discord_public_key = var.discord_public_key
  allowed_role_ids = var.allowed_role_ids
  lambda_role_arn = module.iam.lambda_role_arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  instance_id = module.ec2.instance_id
  lambda_function_arn = module.lambda.lambda_function_arn
  lambda_function_name = module.lambda.lambda_function_name
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}