locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "network"
}

module "grant" {
  source = "../../../modules/resources"

  release = "${local.charts.traefik.chart}-grant"
  paths   = ["${path.module}/manifests/grant.yml"]
}

module "traefik" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.traefik.chart
  versions   = local.charts.traefik.version
  repository = local.charts.traefik.repository

  values = ["${path.module}/values"]
  args = {
    ip = var.gateway_ip
  }

  wait       = false
  depends_on = [module.grant]
}

module "redirect" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.traefik.chart}-redirect"
  paths   = ["${path.module}/manifests/redirect.yml"]

  depends_on = [module.traefik]
}