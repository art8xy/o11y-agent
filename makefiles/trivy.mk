TRIVY := trivy

trivy-req:
	$(call req,$(TRIVY))

trivy-scan: trivy-req
	@$(TRIVY) config --exit-code 0 --severity CRITICAL,HIGH $(PWD)