locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "agent"
}

module "n8n" {
  source    = "../../../modules/release"
  namespace = local.namespace

  release  = local.charts.n8n.chart
  chart    = local.charts.n8n.repository
  versions = local.charts.n8n.version

  values = ["${path.module}/values"]
  wait   = false
}

module "route" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.n8n.chart}-route"
  paths   = ["${path.module}/manifests/route.yml"]

  depends_on = [module.n8n]
}