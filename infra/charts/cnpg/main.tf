locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "postgres"
}

module "cloudnative_pg" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.cnpg.chart
  versions   = local.charts.cnpg.version
  repository = local.charts.cnpg.repository

  values = ["${path.module}/values"]
}