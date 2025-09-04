locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "o11y"
}

module "metrics_server" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.metrics-server.chart
  versions   = local.charts.metrics-server.version
  repository = local.charts.metrics-server.repository

  values = ["${path.module}/values"]
}