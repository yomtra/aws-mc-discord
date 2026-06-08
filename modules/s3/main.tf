resource "aws_s3_bucket" "mc_mod_bucket" {
  bucket = var.bucket_name
}


resource "aws_s3_object" "modpack" {
  key = "mods/modpack.zip"
  bucket = aws_s3_bucket.mc_mod_bucket.id
  source = var.mods
}