locals {
  api   = "https://n8n.o11y.local/api/v1"
  codes = [200, 201]
  headers = {
    "Accept"        = "application/json"
    "Content-type"  = "application/json"
    "X-N8N-API-KEY" = var.n8n_api_key
  }
}