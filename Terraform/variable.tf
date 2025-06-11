variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "simple-auth-cluster"
}

variable "db_username" {
  default = "LW4gImFkbWluIiANCg=="
}

variable "db_password" {
  sensitive = true
  default ="LW4gIjEyMzQ1NiIgDQo="
}
