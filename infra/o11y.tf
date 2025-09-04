module "prometheus" {
  source     = "./charts/prometheus"
  depends_on = [module.gateway]
}

module "rocket" {
  source     = "./charts/rocket"
  depends_on = [module.prometheus]
}

module "metrics-server" {
  source     = "./charts/metrics-server"
  depends_on = [module.prometheus]
}

module "alloy" {
  source     = "./charts/alloy"
  depends_on = [module.prometheus]
}

module "loki" {
  source     = "./charts/loki"
  depends_on = [module.prometheus]
}

module "tempo" {
  source     = "./charts/tempo"
  depends_on = [module.prometheus]
}

module "grafana-postgres" {
  source     = "./charts/postgres"
  service    = "grafana"
  namespace  = "o11y"
  depends_on = [module.cnpg]
}

module "grafana" {
  source = "./charts/grafana"
  depends_on = [
    module.prometheus,
    module.grafana-postgres
  ]
}

module "grafana-mcp" {
  source     = "./charts/grafana-mcp"
  depends_on = [module.grafana]
}