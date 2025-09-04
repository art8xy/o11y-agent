locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "o11y"
}

module "loki" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.loki.chart
  versions   = local.charts.loki.version
  repository = local.charts.loki.repository

  timeout = 1500
  values  = ["${path.module}/values"]
}