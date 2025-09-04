locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "agent"
}

module "minio" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.minio.chart
  versions   = local.charts.minio.version
  repository = local.charts.minio.repository

  values = ["${path.module}/values"]
}

module "routes" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.minio.chart}-routes"
  paths   = ["${path.module}/manifests"]

  depends_on = [module.minio]
}