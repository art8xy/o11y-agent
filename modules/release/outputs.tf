output "id" {
  description = "The ID of the Helm Release"
  value       = helm_release.this.id
}

output "metadata" {
  description = "The metadata of the Helm Release"
  value       = helm_release.this.metadata
}
