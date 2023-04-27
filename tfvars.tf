# VPC variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the VPC subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones to use for the VPC subnets"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}

# Kubernetes variables
variable "kubernetes_version" {
  description = "Version of Kubernetes to deploy"
  default     = "1.21.2"
}

variable "node_instance_type" {
  description = "EC2 instance type for Kubernetes nodes"
  default     = "t3.medium"
}

variable "node_count" {
  description = "Number of Kubernetes nodes to deploy"
  default     = 2
}

variable "minecraft_image_repo" {
  description = "Docker image repository for Minecraft server"
  default     = "my-registry/minecraft"
}

variable "minecraft_image_tag" {
  description = "Docker image tag for Minecraft server"
  default     = "latest"
}

variable "minecraft_port" {
  description = "Port number for Minecraft server"
  default     = 25565
}
