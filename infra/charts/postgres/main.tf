locals {
  charts = yamldecode(file("${path.root}/charts/charts.yml"))
}

module "database" {
  source    = "../../../modules/resources"
  namespace = var.namespace

  release = "${var.service}-db"
  paths   = ["${path.module}/manifests"]
  args = {
    service = var.service
  }
}

module "postgres" {
  source    = "../../../modules/release"
  namespace = var.namespace

  release    = "${var.service}-postgres"
  chart      = local.charts.postgres.chart
  versions   = local.charts.postgres.version
  repository = local.charts.postgres.repository

  values = ["${path.module}/values"]
  args = {
    service = var.service
  }

  sleep      = "1m"
  depends_on = [module.database]
}
