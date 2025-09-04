locals {
  api   = "https://rocket.o11y.local/api/v1"
  codes = [200, 201]
  headers = {
    "Accept"       = "application/json"
    "Content-type" = "application/json"
  }
}