locals {
  dashboards = "${path.module}/dashboards"
}

resource "grafana_folder" "o11y_agent" {
  title = "o11y Agent"
  uid   = "o11y-agent"
}

resource "grafana_dashboard" "this" {
  for_each = { for file in fileset(local.dashboards, "*.json") : file => file }

  folder      = grafana_folder.o11y_agent.uid
  config_json = file("${local.dashboards}/${each.key}")
}

resource "grafana_organization_preferences" "home" {
  home_dashboard_uid = grafana_dashboard.this["opentelemetry-demo.json"].uid
}