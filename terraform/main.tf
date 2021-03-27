terraform {
  required_version = ">= 0.12"
  
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
}

module "ecs" {
  source = "./modules/ecs"

  environment            = var.environment
  cluster                = var.cluster
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  availability_zones     = var.availability_zones
  max_size               = var.max_size
  min_size               = var.min_size
  desired_capacity       = var.desired_capacity
  key_name               = aws_key_pair.ecs.key_name
  instance_type          = var.instance_type
  ecs_aws_ami            = var.aws_ecs_ami
  health_check_path      = var.health_check_path
  docker_image_url_flask = var.docker_image_url_flask
  docker_image_url_nginx = var.docker_image_url_nginx
  flask_app              = var.flask_app
  rds_db_name            = var.rds_db_name
  rds_username           = var.rds_username
  rds_password           = var.rds_password
  rds_instance_class     = var.rds_instance_class
}

resource "aws_key_pair" "ecs" {
  key_name   = "${var.cluster}-key-pair-${var.environment}"
  public_key = file(var.ssh_pubkey_file)
}
