define req
	@which $(1) >/dev/null 2>&1 || { echo >&2 "$(1) is required but not installed."; exit 1; }
endef

include makefiles/globals.mk
include makefiles/terraform.mk
include makefiles/mkcert.mk
include makefiles/trivy.mk
include makefiles/additional.mk