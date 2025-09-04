locals {
  evaluations            = "${path.module}/evaluations"
  evaluation_files_names = fileset(local.evaluations, "*.json")
  evaluation_files_paths = { for filename in local.evaluation_files_names : filename => jsondecode(file("${local.evaluations}/${filename}")) }
}

resource "terracurl_request" "evaluations" {
  name = "evaluations"

  url    = "${local.api}/data-tables"
  method = "POST"

  response_codes = local.codes
  headers        = local.headers

  request_body = jsonencode({
    name = "evaluations"
    columns = [
      {
        name = "alert_name",
        type = "string"
      },
      {
        name = "alert_json",
        type = "string"
      },
      {
        name = "expected_root_cause",
        type = "string"
      }
    ]
  })

  skip_read    = true
  skip_destroy = true

  lifecycle {
    ignore_changes = [headers]
  }
}

resource "terracurl_request" "row" {
  for_each = local.evaluation_files_paths

  name = "row_${replace(each.key, ".json", "")}"

  url    = "${local.api}/data-tables/${jsondecode(terracurl_request.evaluations.response).id}/rows"
  method = "POST"

  response_codes = local.codes
  headers        = local.headers

  request_body = jsonencode({
    data = [
      {
        alert_name          = each.value.alert_name
        alert_json          = each.value.alert_json
        expected_root_cause = each.value.expected_root_cause
      }
    ]
  })

  skip_read    = true
  skip_destroy = true

  lifecycle {
    ignore_changes = [headers]
  }
}