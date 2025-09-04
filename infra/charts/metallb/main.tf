locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "network"
}

module "metallb" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.metallb.chart
  versions   = local.charts.metallb.version
  repository = local.charts.metallb.repository

  values = ["${path.module}/values"]
}

module "pool" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.metallb.chart}-pool"
  paths   = ["${path.module}/manifests"]
  args = {
    ip = var.gateway_ip
  }

  depends_on = [module.metallb]
}