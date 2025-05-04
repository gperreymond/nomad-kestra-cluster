provider "nomad" {
  address = "http://nomad.docker.localhost"
}

provider "minio" {
  minio_server   = "${var.provider_minio_host}:${var.provider_minio_port}"
  minio_user     = var.provider_minio_username
  minio_password = var.provider_minio_password
  minio_ssl      = false
}

provider "postgresql" {
  host     = var.provider_postgres_host
  port     = var.provider_postgres_port
  username = var.provider_postgres_username
  password = var.provider_postgres_password
  sslmode  = "disable"
}
