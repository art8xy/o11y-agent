locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "otel-demo"
}

module "opentelemetry_demo" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.otel-demo.chart
  versions   = local.charts.otel-demo.version
  repository = local.charts.otel-demo.repository

  timeout = 1500
  values  = ["${path.module}/values"]
}

module "route" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.otel-demo.chart}-route"
  paths   = ["${path.module}/manifests"]

  depends_on = [module.opentelemetry_demo]
}