locals {
  charts    = yamldecode(file("${path.root}/charts/charts.yml"))
  namespace = "o11y"
}

resource "grafana_service_account" "mcp" {
  name = "grafana_mcp"
  role = "Viewer"
}

resource "grafana_service_account_token" "mcp" {
  name               = "grafana_mcp_token"
  service_account_id = grafana_service_account.mcp.id
}

module "grafana_mcp" {
  source    = "../../../modules/release"
  namespace = local.namespace

  chart      = local.charts.grafana-mcp.chart
  versions   = local.charts.grafana-mcp.version
  repository = local.charts.grafana-mcp.repository

  values = ["${path.module}/values"]
  args = {
    apiKey = grafana_service_account_token.mcp.key
  }
}

module "mcp_route" {
  source    = "../../../modules/resources"
  namespace = local.namespace

  release = "${local.charts.grafana-mcp.chart}-route"
  paths   = ["${path.module}/manifests/route.yml"]

  depends_on = [module.grafana_mcp]
}