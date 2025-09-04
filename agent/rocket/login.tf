data "http" "admin" {
  url    = "${local.api}/login"
  method = "POST"

  request_headers = local.headers
  request_body = jsonencode({
    user     = "admin"
    password = "admin123"
  })
}