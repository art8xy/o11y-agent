locals {
  templates = "${path.module}/templates"
}

resource "grafana_message_template" "opentelemetry_demo" {
  name               = "OpenTelemetry Demo Template"
  template           = file("${local.templates}/opentelemetry-demo.tpl")
  disable_provenance = false
}

resource "grafana_contact_point" "opentelemetry_demo" {
  name               = "OpenTelemetry Demo Contact Point"
  disable_provenance = true

  webhook {
    http_method = "POST"
    url         = "http://n8n.agent.svc.cluster.local:5678/webhook/alerts/rocket"
    title       = "{{ template \"custom.opentelemetry_demo.title\" . }}"
    message     = "{{ template \"custom.opentelemetry_demo.message\" . }}"
  }

  webhook {
    http_method = "POST"
    url         = "http://n8n.agent.svc.cluster.local:5678/webhook/alerts/agent"

    disable_resolve_message = true
  }
}

resource "grafana_rule_group" "opentelemetry_demo" {
  name               = "opentelemetry-demo"
  folder_uid         = grafana_folder.o11y_agent.uid
  disable_provenance = true
  interval_seconds   = 30

  rule {
    name           = "Ad High CPU Usage"
    condition      = "C"
    no_data_state  = "OK"
    exec_err_state = "Error"
    is_paused      = false

    annotations = {
      __dashboardUid__ = grafana_dashboard.this["opentelemetry-demo.json"].uid
      __panelId__      = "1"
      description      = "The ad service is experiencing high CPU usage."
      summary          = "Ad High CPU Usage"
    }

    labels = {
      app     = "opentelemetry-demo"
      service = "ad"
    }

    notification_settings {
      contact_point   = grafana_contact_point.opentelemetry_demo.name
      group_interval  = "30s"
      group_wait      = "30s"
      repeat_interval = "4h"
    }

    data {
      ref_id         = "A"
      datasource_uid = grafana_data_source.prometheus.uid

      relative_time_range {
        from = 600
        to   = 0
      }

      model = jsonencode({
        expr       = <<-EOT
        100 *
        sum by (pod) (
          rate(container_cpu_usage_seconds_total{
            pod=~"ad-.*",
          }[5m])
        )
        /
        clamp_min(
          sum by (pod) (
            kube_pod_container_resource_limits{
              pod=~"ad-.*",
              resource="cpu",
            }
          ), 0.001
        )
        EOT
        refId      = "A"
        editorMode = "code"
        instant    = true
        range      = false
      })
    }

    data {
      ref_id         = "C"
      datasource_uid = "__expr__"

      relative_time_range {
        from = 0
        to   = 0
      }

      model = jsonencode({
        expression = "A"
        type       = "threshold"
        refId      = "C"
        datasource = {
          type = "__expr__"
          uid  = "__expr__"
        }
        conditions = [
          {
            evaluator = {
              params = [60]
              type   = "gt"
            }
            operator = {
              type = "and"
            }
            reducer = {
              params = []
              type   = "last"
            }
            type = "query"
            query = {
              params = ["C"]
            }
          }
        ]
      })
    }
  }

  rule {
    name           = "Cart High Error Rate"
    for            = "2m"
    condition      = "C"
    no_data_state  = "OK"
    exec_err_state = "Error"
    is_paused      = false

    annotations = {
      "__dashboardUid__" = grafana_dashboard.this["opentelemetry-demo.json"].uid
      "__panelId__"      = "11"
      "description"      = "The cart service is experiencing high error rate."
      "summary"          = "Cart High Error Rate"
    }

    labels = {
      "app"     = "opentelemetry-demo"
      "service" = "cart"
    }

    notification_settings {
      contact_point   = grafana_contact_point.opentelemetry_demo.name
      group_interval  = "30s"
      group_wait      = "30s"
      repeat_interval = "4h"
    }

    data {
      ref_id         = "A"
      datasource_uid = grafana_data_source.prometheus.uid

      relative_time_range {
        from = 600
        to   = 0
      }

      model = jsonencode({
        expr       = <<-EOT
        100 *
        sum by (service_name, span_name) (
          rate(traces_span_metrics_calls_total{
            service_name="cart",
            span_name="POST /oteldemo.CartService/EmptyCart",
            status_code="STATUS_CODE_ERROR"
          }[5m])
        )
        /
        clamp_min(
          sum by (service_name, span_name) (
            rate(traces_span_metrics_calls_total{
              service_name="cart",
              span_name="POST /oteldemo.CartService/EmptyCart"
            }[5m])
          ), 0.000001
        )
        EOT
        refId      = "A"
        editorMode = "code"
        instant    = true
        range      = false
      })
    }

    data {
      ref_id         = "C"
      datasource_uid = "__expr__"

      relative_time_range {
        from = 0
        to   = 0
      }

      model = jsonencode({
        expression = "A"
        type       = "threshold"
        refId      = "C"
        datasource = {
          type = "__expr__"
          uid  = "__expr__"
        }
        conditions = [
          {
            evaluator = {
              params = [50]
              type   = "gt"
            }
            operator = {
              type = "and"
            }
            reducer = {
              params = []
              type   = "last"
            }
            type = "query"
            query = {
              params = ["C"]
            }
          }
        ]
      })
    }
  }

  rule {
    name           = "Recommendation High Error Rate"
    for            = "2m"
    condition      = "C"
    no_data_state  = "OK"
    exec_err_state = "Error"
    is_paused      = false

    annotations = {
      "__dashboardUid__" = grafana_dashboard.this["opentelemetry-demo.json"].uid
      "__panelId__"      = "18"
      "description"      = "The recommendation service is experiencing high error rate."
      "summary"          = "Recommendation High Error Rate"
    }

    labels = {
      "app"     = "opentelemetry-demo"
      "service" = "recommendation"
    }

    notification_settings {
      contact_point   = grafana_contact_point.opentelemetry_demo.name
      group_interval  = "30s"
      group_wait      = "30s"
      repeat_interval = "4h"
    }

    data {
      ref_id         = "A"
      datasource_uid = grafana_data_source.prometheus.uid

      relative_time_range {
        from = 600
        to   = 0
      }

      model = jsonencode({
        expr       = <<-EOT
        100 *
        sum by (target) (
          rate(app_frontend_requests_total{
            target="/api/recommendations",
            status="500"
          }[5m])
        )
        /
        clamp_min(
          sum by (target) (
            rate(app_frontend_requests_total{
              target="/api/recommendations"
            }[5m])
          ),
          0.000001
        )
        EOT
        refId      = "A"
        editorMode = "code"
        instant    = true
        range      = false
      })
    }

    data {
      ref_id         = "C"
      datasource_uid = "__expr__"

      relative_time_range {
        from = 0
        to   = 0
      }

      model = jsonencode({
        expression = "A"
        type       = "threshold"
        refId      = "C"
        datasource = {
          type = "__expr__"
          uid  = "__expr__"
        }
        conditions = [
          {
            evaluator = {
              params = [28]
              type   = "gt"
            }
            operator = {
              type = "and"
            }
            reducer = {
              params = []
              type   = "last"
            }
            type = "query"
            query = {
              params = ["C"]
            }
          }
        ]
      })
    }
  }
}
