resource "aws_instance" "minecraft" {
	ami                    = var.ami_id
	instance_type          = var.instance_type
	subnet_id              = var.subnet_id
	vpc_security_group_ids = var.security_group_ids
	key_name               = aws_key_pair.minecraft_key.key_name
	iam_instance_profile   = var.iam_instance_profile
	user_data = var.server_start_script
	
	root_block_device {
		volume_size = 20
		volume_type = "gp3"
	}

	associate_public_ip_address = false

	tags = {
		Name    = "minecraft-server"
	}
}

resource "aws_key_pair" "minecraft_key" {
  key_name   = "minecraft-key" 
  public_key = file("~/.ssh/minecraft-key.pub") 
}

resource "aws_eip" "minecraft_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "minecraft_eip_assoc" {
  instance_id   = aws_instance.minecraft.id
  allocation_id = aws_eip.minecraft_eip.id
}