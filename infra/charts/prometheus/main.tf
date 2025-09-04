locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "o11y"
}

module "operator" {
  source    = "../../../modules/release"
  namespace = local.namespace

  release    = "${local.charts.prometheus.release}-operator"
  chart      = local.charts.prometheus.chart
  versions   = local.charts.prometheus.version
  repository = local.charts.prometheus.repository

  values = ["${path.module}/values"]
}

module "prometheus" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = local.charts.prometheus.release
  paths   = ["${path.module}/manifests"]

  depends_on = [module.operator]
}