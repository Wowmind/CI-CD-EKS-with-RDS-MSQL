output "cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
