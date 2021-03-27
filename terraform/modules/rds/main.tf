resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "main"
  subnet_ids = var.private_subnet_ids
}

# RDS Security Group (traffic ECS -> RDS)
resource "aws_security_group" "rds" {
  name        = "rds-security-group"
  description = "Allows inbound access from ECS only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = "5432"
    to_port         = "5432"
    security_groups = [var.ecs_security_group]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_rds_cluster" "aurora_db_cluster" {
  cluster_identifier            = "${var.environment}-aurora-cluster"
  engine                        = "aurora-mysql"
  engine_version                = "5.7.mysql_aurora.2.03.2"
  availability_zones            = ["eu-central-1a", "eu-central-1b"]
  database_name                 = var.rds_db_name
  master_username               = var.rds_username
  master_password               = var.rds_password
  backup_retention_period       = 14
  preferred_backup_window       = "02:00-03:00"
  preferred_maintenance_window  = "wed:03:00-wed:04:00"
  db_subnet_group_name          = aws_db_subnet_group.rds_subnet_group.name
  final_snapshot_identifier     = "${var.environment}-aurora-cluster"
  vpc_security_group_ids        = [aws_security_group.rds.id]

  tags = {
    Name         = "${var.environment}-Aurora-DB-Cluster"
    VPC          = var.vpc_id
    Environment  = var.environment
  }
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  count                 = 2
  identifier            = "${var.environment}-aurora-instance-${count.index}"
  cluster_identifier    = aws_rds_cluster.aurora_db_cluster.id
  engine                = "aurora-mysql"
  engine_version        = "5.7.mysql_aurora.2.03.2"
  instance_class        = var.rds_instance_class
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name
  publicly_accessible   = false

  tags = {
    Name         = "${var.environment}-Aurora-DB-Instance-${count.index}"
    VPC          = var.vpc_id
    Environment  = var.environment
  }
}