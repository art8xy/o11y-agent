locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "o11y"
}

module "rocket" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.rocket.chart
  versions   = local.charts.rocket.version
  repository = local.charts.rocket.repository

  values = ["${path.module}/values"]
}

module "route" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.rocket.chart}-route"
  paths   = ["${path.module}/manifests"]

  depends_on = [module.rocket]
}