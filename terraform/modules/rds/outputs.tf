output "rds_cluster_id" {
  value = aws_rds_cluster.aurora_db_cluster.cluster_identifier
}

output "rds_cluster_endpoint" {
  value = aws_rds_cluster.aurora_db_cluster.endpoint
}