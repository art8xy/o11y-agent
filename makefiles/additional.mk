define HELP_MESSAGE
o11y Agent Makefile Help

Usage:
  make <target> [variable=<value> ...]

Terraform Targets:
  tf-fmt                Format files
  tf-switch             Switch to Terraform version
  tf-init               Initialize Terraform
  tf-upgrade            Upgrade Terraform providers
  tf-plan               Show execution plan
  tf-apply              Apply infrastructure
  tf-destroy            Destroy infrastructure
  tf-output             Show infrastructure outputs
  tf-import             Import existing resources
  tf-remove             Remove resource from state
  tf-clean              Clean generated files/folders

Mkcert Targets:
  mk-install            Install mkcert CA
  mk-generate           Generate TLS certificates
  mk-create             Create Kubernetes secrets
  mk-clean              Clean generated certificates

Trivy Targets:
  trivy-scan            Scan project for vulnerabilities

Additional Targets:
  help                  Show this help message
  hosts                 Add domain entries to /etc/hosts
  
endef

.DEFAULT_GOAL := help
export HELP_MESSAGE
.PHONY: help
help:
	@echo "$$HELP_MESSAGE"

define DOMAINS
otel-demo.o11y.local
n8n.o11y.local
minio.o11y.local
minio-api.o11y.local
rocket.o11y.local
grafana.o11y.local
grafana-mcp.o11y.local
alloy.o11y.local
prometheus.o11y.local
endef

export DOMAINS
.ONESHELL:
hosts:
	while IFS= read -r line; do
		echo "$(GATEWAY_IP) $$line";
	done <<< "$(DOMAINS)" | sudo tee -a /etc/hosts > /dev/null