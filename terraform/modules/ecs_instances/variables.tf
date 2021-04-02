variable "region" {
  description = "The AWS region to create resources in."
}

variable "environment" {
  description = "The name of the environment"
}

variable "cluster" {
  description = "The name of the cluster"
}

variable "instance_group" {
  default     = "default"
  description = "The name of the instances that you consider as a group"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "aws_alb_target_group" {
  description = "Target group of Load Balancer"
}

variable "aws_alb_http_listener" {
  description = "Load Balancer HTTP listener "
}

variable "ecs_service_role" {
  description = "ECS Service role"
}

variable "aws_ecs_cluster_id" {
  description = "ECS Cluster Id"
}

variable "aws_ami" {
  description = "The AWS ami id to use"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type to use"
}

variable "max_size" {
  default     = 1
  description = "Maximum size of the nodes in the cluster"
}

variable "min_size" {
  default     = 1
  description = "Minimum size of the nodes in the cluster"
}

variable "desired_capacity" {
  default     = 1
  description = "The desired capacity of the cluster"
}

variable "scaling_adjustment_up" {
  default     = "1"
  description = "How many instances to scale up by when triggered"
}

variable "scaling_adjustment_down" {
  default     = "-1"
  description = "How many instances to scale down by when triggered"
}

variable "scaling_metric_name" {
  default     = "CPUReservation"
  description = "Options: CPUReservation or MemoryReservation"
}

variable "adjustment_type" {
  default     = "ChangeInCapacity"
  description = "Options: ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity"
}

variable "policy_cooldown" {
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
}

variable "evaluation_periods" {
  default     = "2"
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "alarm_period" {
  default     = "120"
  description = "The period in seconds over which the specified statistic is applied."
}

variable "alarm_threshold_up" {
  default     = "30"
  description = "The value against which the specified statistic is compared."
}

variable "alarm_threshold_down" {
  default     = "20"
  description = "The value against which the specified statistic is compared."
}

variable "alarm_actions_enabled" {
  default = true
}

variable "iam_instance_profile_id" {
  description = "The id of the instance profile that should be used for the instances"
}

variable "private_subnet_ids" {
  type        = list
  description = "The list of private subnets to place the instances in"
}

variable "load_balancers" {
  type        = list
  default     = []
  description = "The load balancers to couple to the instances. Only used when NOT using ALB"
}

variable "depends_id" {
  description = "Workaround to wait for the NAT gateway to finish before starting the instances"
}

variable "key_name" {
  description = "SSH key name to be used"
}

variable "ecs_config" {
  default     = "echo '' > /etc/ecs/ecs.config"
  description = "Specify ecs configuration or get it from S3. Example: aws s3 cp s3://some-bucket/ecs.config /etc/ecs/ecs.config"
}

variable "rds_cluster" {  
  description = "Provisioned RDS Cluster"
}

variable "rds_hostname" {  
  description = "Provisioned RDS host name"
}

variable "rds_port" {  
  description = "Provisioned RDS port"
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

variable "docker_image_url_flask" {
  description = "Docker image to run in the ECS cluster"  
}

variable "docker_image_url_nginx" {
  description = "Docker image to run in the ECS cluster"  
}

variable "flask_app" {
  description = "FLASK APP variable"  
}