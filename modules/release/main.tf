locals {
  release = coalesce(var.release, var.chart)

  files = flatten([
    for p in var.values : (length(try(fileset(p, "*.yml"), [])) > 0 ? [for f in fileset(p, "*.yml") : "${p}/${f}"] : [p])
  ])

  values = [for fullpath in local.files : templatefile(fullpath, var.args)]
}

resource "helm_release" "this" {
  name       = local.release
  chart      = var.chart
  repository = var.repository
  version    = var.versions
  values     = local.values

  create_namespace = true
  namespace        = var.namespace

  timeout = var.timeout
  wait    = var.wait
}

resource "time_sleep" "this" {
  count           = var.sleep != null ? 1 : 0
  create_duration = var.sleep
  depends_on      = [helm_release.this]
}