output "resources" {
  description = "Rendered manifests as JSON"
  value       = helm_release.this.resources
}
