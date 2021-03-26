module "ecs_instances" {
  source = "../ecs_instances"

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
  iam_instance_profile_id = aws_iam_instance_profile.ecs.id
  key_name                = var.key_name
  load_balancers          = var.load_balancers
  depends_id              = module.network.depends_id
  docker_image_url_flask  = var.docker_image_url_flask
  docker_image_url_nginx  = var.docker_image_url_nginx
}

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster
}