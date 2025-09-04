data "http" "grafana_bot" {
  url    = "https://rocket.o11y.local/api/v1/login"
  method = "POST"

  request_headers = local.headers
  request_body = jsonencode({
    user     = "grafana"
    password = "grafana123"
  })
}

data "http" "agent_bot" {
  url    = "https://rocket.o11y.local/api/v1/login"
  method = "POST"

  request_headers = local.headers
  request_body = jsonencode({
    user     = "agent"
    password = "agent123"
  })
}

resource "n8n_credential" "grafana_bot" {
  name = "Rocket.Chat Grafana Credentials"
  type = "rocketchatApi"
  data = jsonencode({
    userId  = jsondecode(data.http.grafana_bot.response_body).data.userId
    authKey = jsondecode(data.http.grafana_bot.response_body).data.authToken
    domain  = "http://rocketchat-rocketchat.o11y.svc.cluster.local"
  })

  lifecycle {
    ignore_changes = [data]
  }
}

resource "n8n_credential" "agent_bot" {
  name = "Rocket.Chat Agent Credentials"
  type = "rocketchatApi"
  data = jsonencode({
    userId  = jsondecode(data.http.agent_bot.response_body).data.userId
    authKey = jsondecode(data.http.agent_bot.response_body).data.authToken
    domain  = "http://rocketchat-rocketchat.o11y.svc.cluster.local"
  })

  lifecycle {
    ignore_changes = [data]
  }
}

resource "n8n_credential" "mistral" {
  name = "Mistral Credentials"
  type = "mistralCloudApi"
  data = jsonencode({
    apiKey = var.mistral_api_key
  })

  lifecycle {
    ignore_changes = [data]
  }
}

resource "n8n_credential" "valkey" {
  name = "Valkey Credentials"
  type = "redis"
  data = jsonencode({
    host = "valkey.agent.svc.cluster.local"

    disableTlsVerification = true
  })
}

resource "n8n_credential" "minio" {
  name = "MinIO Credentials"
  type = "s3"
  data = jsonencode({
    endpoint        = "http://minio.agent.svc.cluster.local:9000"
    region          = "us-east-1"
    accessKeyId     = "admin"
    secretAccessKey = "admin123"
    forcePathStyle  = true
  })
}

resource "n8n_credential" "n8n" {
  name = "n8n Credentials"
  type = "n8nApi"
  data = jsonencode({
    baseUrl = "http://n8n.agent.svc.cluster.local:5678/api/v1"
    apiKey  = var.n8n_api_key,
  })
}