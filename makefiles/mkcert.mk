MKCERT := mkcert

MKCERT_DOMAINS := "o11y.local" "*.o11y.local"
MKCERT_CERT := o11y-cert.pem
MKCERT_KEY := o11y-key.pem
MKCERT_SECRET := o11y-tls
MKCERT_NAMESPACE := kube-system

mk-req:
	$(call req,$(MKCERT))

mk-install: mk-req
	@$(MKCERT) -install

mk-generate: mk-install
	@$(MKCERT) -key-file $(MKCERT_KEY) -cert-file $(MKCERT_CERT) $(MKCERT_DOMAINS)

mk-create: mk-generate
	@kubectl -n $(MKCERT_NAMESPACE) create secret tls $(MKCERT_SECRET) --key $(MKCERT_KEY) --cert $(MKCERT_CERT)

mk-clean:
	@rm -f $(MKCERT_CERT) $(MKCERT_KEY)