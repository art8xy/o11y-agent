locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "o11y"
}

module "tempo" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.tempo.chart
  versions   = local.charts.tempo.version
  repository = local.charts.tempo.repository

  timeout = 1500
  values  = ["${path.module}/values"]
}
