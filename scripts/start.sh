#!/bin/bash

apt-get update -y
apt-get install -y docker.io curl unzip

# install aws cli to download custom modpack from s3
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp/
sudo /tmp/aws/install
rm -rf /tmp/awscliv2.zip /tmp/aws

mkdir -p /opt/minecraft

aws s3 cp s3://mc-mods-bucket/mods/modpack.zip /tmp/modpack.zip
unzip /tmp/modpack.zip -d /opt/minecraft
rm /tmp/modpack.zip

systemctl enable docker
systemctl start docker

docker run -d \
  --restart unless-stopped \
  -p 25565:25565 \
  -e EULA=TRUE \
  -e TYPE=FORGE \
  -e MEMORY=6G \
  -e VERSION=1.20.1 \
  -e FORGE_VERSION=47.4.0 \
  -v /opt/minecraft:/data \
 --name minecraft \
  itzg/minecraft-server:java17

  #place your world folder inside /opt/minecraft/world \
  #-e WORLD=world \ 

  #install modpack from curseforge or other source
  #-e MODPACK=https://example.com/mods/modpack.zip