locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  files     = fileset("${path.module}/configs", "*.alloy")
  config    = join("\n", [for f in local.files : file("${path.module}/configs/${f}")])
  namespace = "o11y"
}

module "alloy" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.alloy.chart
  versions   = local.charts.alloy.version
  repository = local.charts.alloy.repository

  values = ["${path.module}/values"]
  args = {
    config = indent(6, local.config)
  }
}

module "route" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.alloy.chart}-route"
  paths   = ["${path.module}/manifests/route.yml"]

  depends_on = [module.alloy]
}