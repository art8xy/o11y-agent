module "otel-demo" {
  source     = "./charts/otel-demo"
  depends_on = [module.gateway]
}