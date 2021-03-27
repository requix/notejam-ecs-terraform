variable "environment" {
  description = "A name to describe the environment we're creating."
}

variable "cluster" {
  description = "A name of cluster."
}

variable "profile" {
  description = "The AWS-CLI profile for the account to create resources in."
}

variable "region" {
  description = "The AWS region to create resources in."
}

variable "aws_ecs_ami" {
  description = "The AMI to seed ECS instances with."
}

variable "vpc_cidr" {
  description = "The IP range to attribute to the virtual network."
}

variable "public_subnet_cidrs" {
  description = "The IP ranges to use for the public subnets in your VPC."
  type = list
}

variable "private_subnet_cidrs" {
  description = "The IP ranges to use for the private subnets in your VPC."
  type = list
}

variable "availability_zones" {
  description = "The AWS availability zones to create subnets in."
  type = list
}

variable "max_size" {
  description = "Maximum number of instances in the ECS cluster."
}

variable "min_size" {
  description = "Minimum number of instances in the ECS cluster."
}

variable "desired_capacity" {
  description = "Ideal number of instances in the ECS cluster."
}

variable "instance_type" {
  description = "Size of instances in the ECS cluster."
}

variable "flask_app" {
  description = "FLASK APP variable"  
}

variable "docker_image_url_flask" {
  description = "Docker image to run in the ECS cluster"  
}

variable "docker_image_url_nginx" {
  description = "Docker image to run in the ECS cluster"  
}

variable "rds_db_name" {
  description = "RDS database name"
  default     = "mydb"
}

variable "rds_username" {
  description = "RDS database username"
  default     = "dbuser"
}

variable "rds_password" {
  description = "RDS database password"
}

variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t2.micro"
}

variable "health_check_path" {  
  description = "Health check path"
}

variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"  
}

output "default_alb_target_group" {
  value = module.ecs.default_alb_target_group
}