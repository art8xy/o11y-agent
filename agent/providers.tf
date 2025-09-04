provider "terracurl" {}

provider "grafana" {
  url  = "https://grafana.o11y.local"
  auth = "admin:admin123"
}

provider "n8n" {
  endpoint = "https://n8n.o11y.local"
  api_key  = var.n8n_api_key
}

provider "minio" {
  minio_server   = "minio-api.o11y.local"
  minio_user     = "admin"
  minio_password = "admin123"
  minio_ssl      = "true"
}