locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "agent"
}

module "valkey" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.valkey.chart
  versions   = local.charts.valkey.version
  repository = local.charts.valkey.repository

  values = ["${path.module}/values"]
}