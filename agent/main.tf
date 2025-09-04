module "grafana" {
  source = "./grafana"
}

module "minio" {
  source = "./minio"
}

module "rocket" {
  source = "./rocket"
}

module "n8n" {
  source          = "./n8n"
  n8n_api_key     = var.n8n_api_key
  mistral_api_key = var.mistral_api_key
  depends_on = [
    module.grafana,
    module.minio,
    module.rocket
  ]
}