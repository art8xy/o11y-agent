locals {
  release = coalesce(var.release, uuid())

  files = flatten([
    for p in var.paths : (length(try(fileset(p, "*.yml"), [])) > 0 ? [for f in fileset(p, "*.yml") : "${p}/${f}"] : [p])
  ])

  resources = [for fullpath in local.files : templatefile(fullpath, var.args)]
}

resource "helm_release" "this" {
  name       = local.release
  chart      = "raw"
  repository = "https://art8xy.github.io/charts"
  version    = "1.0.0"

  create_namespace = true
  namespace        = var.namespace

  timeout = var.timeout
  wait    = var.wait

  values = [yamlencode({
    resources = local.resources
  })]
}

resource "time_sleep" "this" {
  count           = var.sleep != null ? 1 : 0
  create_duration = var.sleep
  depends_on      = [helm_release.this]
}
