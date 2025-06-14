variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "simple-auth-cluster"
}

variable "db_username" {
  sensitive = true
  type = string
}

variable "db_password" {
  sensitive = true
  type = string
}
