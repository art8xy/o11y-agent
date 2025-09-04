provider "kubernetes" {
  config_path    = var.kube_config
  config_context = var.kube_ctx
}

provider "helm" {
  kubernetes = {
    config_path    = var.kube_config
    config_context = var.kube_ctx
  }
}

provider "grafana" {
  url  = "https://grafana.o11y.local"
  auth = "admin:admin123"
}