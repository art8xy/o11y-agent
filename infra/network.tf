module "gateway" {
  source = "../modules/crds"
  url    = "https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml"
}

module "metallb" {
  source     = "./charts/metallb"
  gateway_ip = var.gateway_ip
  depends_on = [
    module.gateway,
    module.prometheus
  ]
}

module "traefik" {
  source     = "./charts/traefik"
  gateway_ip = var.gateway_ip
  depends_on = [module.metallb]
}