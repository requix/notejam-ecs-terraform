resource "aws_security_group" "bastion" {
  name        = "Bastion host for ${local.environment}"
  description = "Allow SSH access to bastion host and outbound internet access"
  vpc_id      = local.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Environment = local.environment
  }
}

resource "aws_security_group_rule" "ssh" {
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.allowed_hosts
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "internet" {
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "intranet" {
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.internal_networks
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_to_ecs" {
  protocol                 = "TCP"
  from_port                = 22
  to_port                  = 22
  type                     = "ingress"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = var.ecs_security_group
}

