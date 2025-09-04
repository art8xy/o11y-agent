TERRAFORM := terraform
TFSWITCH := tfswitch
TERRAFORM_VERSION := 1.14.8

TF_GENERATED := \
	.terraform \
	.terraform.lock.hcl \
	.terraform.tfstate.lock.info \
	terraform.tfstate \
	terraform.tfstate.backup

export TF_VAR_kube_ctx := $(shell kubectl config current-context 2> /dev/null)
export TF_VAR_kube_config := ~/.kube/config
export TF_VAR_gateway_ip := $(GATEWAY_IP)

export TF_VAR_n8n_api_key := $(N8N_API_KEY)
export TF_VAR_mistral_api_key := $(MISTRAL_API_KEY)

TF_WORKDIR ?= $(dir)
TF_ARGS := $(if $(approve),-auto-approve) $(if $(target),-target=$(target))
TF := $(TERRAFORM) -chdir=$(TF_WORKDIR)

tf-req:
	$(call req,$(TFSWITCH))

tf-switch: tf-req
	@$(TFSWITCH) $(TERRAFORM_VERSION)

tf-fmt: tf-req
	@$(TF) fmt -recursive .

tf-init: tf-switch tf-fmt
	@$(TF) init

tf-upgrade: tf-switch tf-fmt
	@$(TF) init -upgrade

tf-plan: tf-init
	@$(TF) plan

tf-apply: tf-init
	@$(TF) apply $(TF_ARGS)

tf-destroy: tf-init
	@$(TF) destroy $(TF_ARGS)

tf-output: tf-init
	@$(TF) output

tf-import: tf-init
	@$(TF) import $(resource) $(id)

tf-remove: tf-init
	@$(TF) state rm $(resource)

tf-clean:
	@rm -rf $(addprefix $(TF_WORKDIR)/,$(TF_GENERATED))