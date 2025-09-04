resource "terracurl_request" "alerts" {
  name = "alerts"

  url    = "${local.api}/channels.create"
  method = "POST"

  response_codes = local.codes
  headers = merge(local.headers, {
    "X-Auth-Token" = jsondecode(data.http.admin.response_body).data.authToken
    "X-User-Id"    = jsondecode(data.http.admin.response_body).data.userId
  })

  request_body = jsonencode({
    name = "Alerts"
    members = [
      jsondecode(terracurl_request.grafana_bot.response).user.username,
      jsondecode(terracurl_request.agent_bot.response).user.username,
    ]
  })

  skip_read    = true
  skip_destroy = true

  lifecycle {
    ignore_changes = [headers]
  }
}