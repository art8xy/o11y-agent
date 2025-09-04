resource "grafana_data_source" "prometheus" {
  name       = "Prometheus"
  type       = "prometheus"
  uid        = "prometheus"
  url        = "http://prometheus.o11y.svc.cluster.local:9090"
  is_default = true
}

resource "grafana_data_source" "loki" {
  name = "Loki"
  type = "loki"
  uid  = "loki"
  url  = "http://loki.o11y.svc.cluster.local:3100"
}

resource "grafana_data_source" "tempo" {
  name = "Tempo"
  type = "tempo"
  uid  = "tempo"
  url  = "http://tempo.o11y.svc.cluster.local:3200"
  json_data_encoded = jsonencode({
    nodeGraph = {
      enabled = true
    }
    serviceMap = {
      datasourceUid = grafana_data_source.prometheus.uid
    }
  })
}