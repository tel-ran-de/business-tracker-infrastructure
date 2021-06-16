PWD := $(shell pwd)
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
	TERRAFORM = '../vendor/linux/terraform'
endif
ifeq ($(UNAME_S),Darwin)
	TERRAFORM = '../vendor/darwin/terraform'
endif

#TF_VAR_FILES := -var-file="./variables/00-master.tfvars" -var-file="./.decrypted/secrets.tfvars"
TF_VAR_FILES := -var-file="./variables/00-master.tfvars"

.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: init
init: ## run terraform init
	$(TERRAFORM) init

.PHONY: plan
plan: ## run terraform plan
	$(TERRAFORM) plan $(TF_VAR_FILES)

.PHONY: show
show: ## run terraform show
	$(TERRAFORM) show

.PHONY: apply
apply: ## run terraform apply
	$(TERRAFORM) apply -auto-approve $(TF_VAR_FILES)

.PHONY: destroy
destroy: ## run terraform destroy
	$(TERRAFORM) destroy $(TF_VAR_FILES)

.PHONY: taint-bastion
taint-bastion: ## Taints bastion instance
	$(TERRAFORM) taint module.bastion.aws_instance.bastion

.PHONY: untaint-bastion
untaint-bastion: ## Untaints bastion instance
	$(TERRAFORM) untaint module.bastion.aws_instance.bastion

.PHONY: validate
validate:  ## Test/Validate code
	$(TERRAFORM) validate

.PHONY: format
format:  ## Format code
	$(TERRAFORM) format


##################################################################################################

encrypt: _check-enc-key ## encrypt secret data
	@mkdir -pv .decrypted
	@mkdir -pv secrets
	@openssl enc -e -blowfish -k $(ENC_KEY) -md sha256 -in .decrypted/secrets.tfvars -out secrets/secrets.tfvars.encrypted
	@openssl enc -e -blowfish  -k $(ENC_KEY) -md sha256 -in .decrypted/id_rsa -out secrets/id_rsa.encrypted


decrypt: _check-enc-key ## decrypt secret data
	@mkdir -pv .decrypted
	@mkdir -pv secrets
	@openssl enc -d -blowfish -k $(ENC_KEY) -md sha256 -in secrets/secrets.tfvars.encrypted -out .decrypted/secrets.tfvars
	@openssl enc -d -blowfish -k $(ENC_KEY) -md sha256 -in secrets/id_rsa.encrypted -out .decrypted/id_rsa

_check-enc-key:
ifndef ENC_KEY
	$(error ENC_KEY is undefined)
endif
