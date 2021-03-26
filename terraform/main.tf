provider "aws" {
  region = var.region
  profile = var.profile
}

module "ecs" {
  source = "./modules/ecs"

  environment            = var.environment
  cluster                = var.environment
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
  docker_image_url_flask = var.docker_image_url_flask
  docker_image_url_nginx = var.docker_image_url_nginx
}

resource "aws_key_pair" "ecs" {
  key_name   = "${var.ecs_cluster_name}-key-pair-${var.environment}"
  public_key = file(var.ssh_pubkey_file)
}
