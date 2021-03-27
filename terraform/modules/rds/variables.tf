variable "environment" {
  description = "The name of the environment"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "private_subnet_ids" {
  type        = list
  description = "List of private subnet ids for every availability zone"
}

variable "ecs_security_group" {
  description = "Security group id of ECS instance"
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