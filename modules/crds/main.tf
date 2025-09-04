data "http" "this" {
  url = var.url
}

locals {
  manifests_raw = provider::kubernetes::manifest_decode_multi(data.http.this.response_body)
  manifests = [
    for d in local.manifests_raw : merge(
      { for k, v in d : k => v if k != "status" },
      {
        metadata = {
          for mk, mv in lookup(d, "metadata", {}) :
          mk => mv if mk != "creationTimestamp"
        }
      }
    )
  ]
}

resource "kubernetes_manifest" "this" {
  for_each = { for idx, doc in local.manifests : idx => doc }
  manifest = each.value
}