output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "vpc_id" {
  value = aws_vpc.main.id
}
