module "n8n-postgres" {
  source     = "./charts/postgres"
  service    = "n8n"
  namespace  = "agent"
  depends_on = [module.cnpg]
}

module "valkey" {
  source     = "./charts/valkey"
  depends_on = [module.prometheus]
}

module "minio" {
  source     = "./charts/minio"
  depends_on = [module.prometheus]
}

module "n8n" {
  source = "./charts/n8n"
  depends_on = [
    module.gateway,
    module.n8n-postgres
  ]
}