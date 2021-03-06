variable "region" {
  description = "The AWS region to create resources in."
}

variable "environment" {
  description = "The name of the environment"
}

variable "cluster" {
  default     = "default"
  description = "The name of the ECS cluster"
}

variable "instance_group" {
  default     = "default"
  description = "The name of the instances that you consider as a group"
}

variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  type        = list(any)
  description = "List of private cidrs, for every availability zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "public_subnet_cidrs" {
  type        = list(any)
  description = "List of public cidrs, for every availability zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "load_balancers" {
  type        = list(any)
  default     = []
  description = "The load balancers to couple to the instances"
}

variable "availability_zones" {
  type        = list(any)
  description = "List of availability zones you want. Example: eu-central-1a and eu-central-1b"
}

variable "max_size" {
  description = "Maximum size of the nodes in the cluster"
}

variable "min_size" {
  description = "Minimum size of the nodes in the cluster"
}

variable "desired_capacity" {
  description = "The desired capacity of the cluster"
}

variable "key_name" {
  description = "SSH key name to be used"
}

variable "instance_type" {
  description = "AWS instance type to use"
}

variable "ecs_aws_ami" {
  description = "The AWS ami id to use for ECS"
}

variable "ecs_config" {
  default     = "echo '' > /etc/ecs/ecs.config"
  description = "Specify ecs configuration or get it from S3. Example: aws s3 cp s3://some-bucket/ecs.config /etc/ecs/ecs.config"
}

variable "rds_db_name" {
  description = "RDS database name"
}

variable "rds_username" {
  description = "RDS database username"
}

variable "rds_password" {
  description = "RDS database password"
}

variable "rds_instance_class" {
  description = "RDS instance type"
}

variable "health_check_path" {
  description = "Health check path"
}

variable "docker_image_url_flask" {
  description = "Docker image to run in the ECS cluster"
}

variable "docker_image_url_nginx" {
  description = "Docker image to run in the ECS cluster"
}

variable "flask_app" {
  description = "FLASK APP variable"
}

variable "log_retention_in_days" {
  default = 30
}
