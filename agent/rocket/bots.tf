resource "terracurl_request" "grafana_bot" {
  name = "grafana_bot"

  url    = "${local.api}/users.create"
  method = "POST"

  response_codes = local.codes
  headers = merge(local.headers, {
    "X-Auth-Token" = jsondecode(data.http.admin.response_body).data.authToken
    "X-User-Id"    = jsondecode(data.http.admin.response_body).data.userId
  })

  request_body = jsonencode({
    name              = "Grafana"
    email             = "grafana@o11y.local"
    username          = "grafana"
    password          = "grafana123"
    roles             = ["bot"]
    setRandomPassword = false
    sendWelcomeEmail  = false
    verified          = false
  })

  skip_read    = true
  skip_destroy = true

  lifecycle {
    ignore_changes = [headers]
  }
}

resource "terracurl_request" "agent_bot" {
  name = "agent_bot"

  url    = "${local.api}/users.create"
  method = "POST"

  response_codes = local.codes
  headers = merge(local.headers, {
    "X-Auth-Token" = jsondecode(data.http.admin.response_body).data.authToken
    "X-User-Id"    = jsondecode(data.http.admin.response_body).data.userId
  })

  request_body = jsonencode({
    name              = "Agent"
    email             = "agent@o11y.local"
    username          = "agent"
    password          = "agent123"
    roles             = ["bot"]
    setRandomPassword = false
    sendWelcomeEmail  = false
    verified          = false
  })

  skip_read    = true
  skip_destroy = true

  lifecycle {
    ignore_changes = [headers]
  }
}