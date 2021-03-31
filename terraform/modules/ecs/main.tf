module "network" {
  source               = "../network"
  
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  depends_id           = ""
}

module "bastion_host" {
  source               = "../bastion_host"
  
  environment          = var.environment
  subnet_id            = module.network.public_subnet_ids[0]
  internal_networks    = var.private_subnet_cidrs
  ssh_key              = var.key_name
}

module "rds" {
 source               = "../rds"
 
 environment          = var.environment
 vpc_id               = module.network.vpc_id
 private_subnet_ids   = module.network.private_subnet_ids
 rds_db_name          = var.rds_db_name
 rds_username         = var.rds_username
 rds_password         = var.rds_password
 rds_instance_class   = var.rds_instance_class
 ecs_security_group   = module.ecs_instances.ecs_instance_security_group_id
}

module "ecs_instances" {
  source = "../ecs_instances"

  region                  = var.region
  environment             = var.environment
  cluster                 = var.cluster
  instance_group          = var.instance_group
  private_subnet_ids      = module.network.private_subnet_ids
  aws_ami                 = var.ecs_aws_ami
  instance_type           = var.instance_type
  max_size                = var.max_size
  min_size                = var.min_size
  desired_capacity        = var.desired_capacity
  vpc_id                  = module.network.vpc_id
  aws_alb_target_group    = module.alb.default_alb_target_group
  aws_alb_http_listener   = module.alb.http_alb_listener
  ecs_service_role        = aws_iam_role.ecs_service_role
  aws_ecs_cluster_id      = aws_ecs_cluster.cluster.id
  iam_instance_profile_id = aws_iam_instance_profile.ecs.id
  key_name                = var.key_name
  load_balancers          = var.load_balancers
  depends_id              = module.network.depends_id
  docker_image_url_flask  = var.docker_image_url_flask
  docker_image_url_nginx  = var.docker_image_url_nginx
  rds_cluster             = module.rds.rds_cluster
  rds_hostname            = module.rds.rds_cluster_hostname
  rds_port                = module.rds.rds_cluster_port
  rds_db_name             = var.rds_db_name
  rds_username            = var.rds_username
  rds_password            = var.rds_password
  flask_app               = var.flask_app
}

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster
}