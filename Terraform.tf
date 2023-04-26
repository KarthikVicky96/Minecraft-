# Provider configuration
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# VPC configuration
resource "aws_vpc" "minecraft_vpc" {
  cidr_block = "10.0.0.0/16" # Replace with your desired VPC CIDR block

  tags = {
    Name = "minecraft-vpc"
  }
}

# Subnet configuration
resource "aws_subnet" "minecraft_subnet" {
  vpc_id     = aws_vpc.minecraft_vpc.id
  cidr_block = "10.0.1.0/24" # Replace with your desired subnet CIDR block

  tags = {
    Name = "minecraft-subnet"
  }
}

# Internet Gateway configuration
resource "aws_internet_gateway" "minecraft_gateway" {
  vpc_id = aws_vpc.minecraft_vpc.id

  tags = {
    Name = "minecraft-gateway"
  }
}

# Route Table configuration
resource "aws_route_table" "minecraft_route_table" {
  vpc_id = aws_vpc.minecraft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_gateway.id
  }

  tags = {
    Name = "minecraft-route-table"
  }
}

# Subnet Association configuration
resource "aws_route_table_association" "minecraft_subnet_association" {
  subnet_id      = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.minecraft_route_table.id
}

# Security Group configuration
resource "aws_security_group" "minecraft_security_group" {
  name_prefix = "minecraft-"

  ingress {
    from_port = 25565 # Minecraft server default port
    to_port   = 25565 # Minecraft server default port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from all sources
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "minecraft-security-group"
  }
}
