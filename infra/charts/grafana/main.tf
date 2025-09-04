locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "o11y"
}

module "grafana" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.grafana.chart
  versions   = local.charts.grafana.version
  repository = local.charts.grafana.repository

  timeout = 1500
  values  = ["${path.module}/values"]
}

module "route" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.grafana.chart}-route"
  paths   = ["${path.module}/manifests/route.yml"]

  sleep      = "1m"
  depends_on = [module.grafana]
}