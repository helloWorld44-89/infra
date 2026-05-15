.DEFAULT_GOAL := help

ANSIBLE_DIR  := ansible
TF_BASE      := terraform/deployments

# Pass extra flags via environment:  ANSIBLE_OPTS="--tags foo" make ansible-k8s
#                                     TF_OPTS="-auto-approve"   make tf-apply-k8s
ANSIBLE_OPTS ?=
TF_OPTS      ?=

# ── Help ──────────────────────────────────────────────────────────────────────
.PHONY: help
help: ## Show this help
	@printf "\n\033[1mHomelab Infrastructure\033[0m — available targets:\n\n"
	@grep -E '^(## ──|[a-zA-Z0-9_-]+:.*## )' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*## "} \
		       /^## ──/{printf "\n  \033[90m%s\033[0m\n",substr($$0,4)} \
		       /^[^#]/{printf "  \033[36m%-26s\033[0m %s\n",$$1,$$2}'
	@printf "\n"

# ── Dependencies ──────────────────────────────────────────────────────────────
## ── Setup
.PHONY: install
install: ## Install Ansible collection dependencies (requirements.yml)
	ansible-galaxy collection install -r $(ANSIBLE_DIR)/requirements.yml --upgrade

# ── Full-stack workflows ───────────────────────────────────────────────────────
## ── End-to-end deploy (Terraform then Ansible)
.PHONY: deploy-k8s deploy-vault deploy-docker

deploy-k8s: tf-apply-k8s ansible-k8s ## Provision K3s VMs then bootstrap the cluster
deploy-vault: tf-apply-vault ansible-vault ## Provision Vault VM then install + initialise Vault
deploy-docker: tf-apply-docker-prod ansible-docker ## Provision prod Docker VMs then configure hosts
deploy-openclaw: tf-apply-openclaw ansible-openclaw ## Provision OpenClaw VM then install the agent framework

# ── Ansible playbooks ─────────────────────────────────────────────────────────
## ── Ansible
.PHONY: ansible-k8s ansible-docker ansible-proxmox ansible-vault ansible-monitoring ansible-dev ansible-keyshift ansible-openclaw

ansible-k8s: ## K3s: master init, worker join, NFS provisioner
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/k8s-master.yml $(ANSIBLE_OPTS)

ansible-docker: ## Docker: configure production + dev hosts
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/dockerHosts.yml $(ANSIBLE_OPTS)

ansible-proxmox: ## Proxmox: node_exporter + firewall rules on all PVE nodes
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/proxmox.yml $(ANSIBLE_OPTS)

ansible-vault: ## Vault: install binary, configure Raft, init + unseal
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/prodVault.yml $(ANSIBLE_OPTS)

ansible-monitoring: ## Monitoring: Prometheus + Grafana + AlertManager on prod-debsrv
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/prodDeb.yml $(ANSIBLE_OPTS)

ansible-dev: ## Dev: configure dev Docker environment
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/deploy-dev.yml $(ANSIBLE_OPTS)

ansible-keyshift: ## Keyshift: deploy keyshift application
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/deploy-keyshift.yml $(ANSIBLE_OPTS)

ansible-openclaw: ## OpenClaw: install AI agent framework on prod-openclaw-01
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/prodOpenclaw.yml $(ANSIBLE_OPTS)

# ── Terraform: kubernetes ──────────────────────────────────────────────────────
## ── Terraform — kubernetes
.PHONY: tf-init-k8s tf-plan-k8s tf-apply-k8s tf-destroy-k8s

tf-init-k8s: ## TF init: kubernetes cluster nodes
	terraform -chdir=$(TF_BASE)/kubernetes init

tf-plan-k8s: tf-init-k8s ## TF plan: kubernetes cluster nodes
	terraform -chdir=$(TF_BASE)/kubernetes plan $(TF_OPTS)

tf-apply-k8s: tf-init-k8s ## TF apply: kubernetes cluster nodes
	terraform -chdir=$(TF_BASE)/kubernetes apply $(TF_OPTS)

tf-destroy-k8s: ## TF destroy: kubernetes cluster nodes (destructive)
	terraform -chdir=$(TF_BASE)/kubernetes destroy $(TF_OPTS)

# ── Terraform: dockerProd ─────────────────────────────────────────────────────
## ── Terraform — dockerProd
.PHONY: tf-init-docker-prod tf-plan-docker-prod tf-apply-docker-prod tf-destroy-docker-prod

tf-init-docker-prod: ## TF init: production Docker hosts
	terraform -chdir=$(TF_BASE)/dockerProd init

tf-plan-docker-prod: tf-init-docker-prod ## TF plan: production Docker hosts
	terraform -chdir=$(TF_BASE)/dockerProd plan $(TF_OPTS)

tf-apply-docker-prod: tf-init-docker-prod ## TF apply: production Docker hosts
	terraform -chdir=$(TF_BASE)/dockerProd apply $(TF_OPTS)

tf-destroy-docker-prod: ## TF destroy: production Docker hosts (destructive)
	terraform -chdir=$(TF_BASE)/dockerProd destroy $(TF_OPTS)

# ── Terraform: dockerDev ──────────────────────────────────────────────────────
## ── Terraform — dockerDev
.PHONY: tf-init-docker-dev tf-plan-docker-dev tf-apply-docker-dev tf-destroy-docker-dev

tf-init-docker-dev: ## TF init: dev Docker host
	terraform -chdir=$(TF_BASE)/dockerDev init

tf-plan-docker-dev: tf-init-docker-dev ## TF plan: dev Docker host
	terraform -chdir=$(TF_BASE)/dockerDev plan $(TF_OPTS)

tf-apply-docker-dev: tf-init-docker-dev ## TF apply: dev Docker host
	terraform -chdir=$(TF_BASE)/dockerDev apply $(TF_OPTS)

tf-destroy-docker-dev: ## TF destroy: dev Docker host (destructive)
	terraform -chdir=$(TF_BASE)/dockerDev destroy $(TF_OPTS)

# ── Terraform: vault ──────────────────────────────────────────────────────────
## ── Terraform — vault
.PHONY: tf-init-vault tf-plan-vault tf-apply-vault tf-destroy-vault

tf-init-vault: ## TF init: Vault server
	terraform -chdir=$(TF_BASE)/vault init

tf-plan-vault: tf-init-vault ## TF plan: Vault server
	terraform -chdir=$(TF_BASE)/vault plan $(TF_OPTS)

tf-apply-vault: tf-init-vault ## TF apply: Vault server
	terraform -chdir=$(TF_BASE)/vault apply $(TF_OPTS)

tf-destroy-vault: ## TF destroy: Vault server (destructive)
	terraform -chdir=$(TF_BASE)/vault destroy $(TF_OPTS)

# ── Terraform: monitoring ─────────────────────────────────────────────────────
## ── Terraform — monitoring
.PHONY: tf-init-monitoring tf-plan-monitoring tf-apply-monitoring tf-destroy-monitoring

tf-init-monitoring: ## TF init: monitoring server
	terraform -chdir=$(TF_BASE)/Monitoring init

tf-plan-monitoring: tf-init-monitoring ## TF plan: monitoring server
	terraform -chdir=$(TF_BASE)/Monitoring plan $(TF_OPTS)

tf-apply-monitoring: tf-init-monitoring ## TF apply: monitoring server
	terraform -chdir=$(TF_BASE)/Monitoring apply $(TF_OPTS)

tf-destroy-monitoring: ## TF destroy: monitoring server (destructive)
	terraform -chdir=$(TF_BASE)/Monitoring destroy $(TF_OPTS)

# ── Terraform: keyshift ───────────────────────────────────────────────────────
## ── Terraform — keyshift
.PHONY: tf-init-keyshift tf-plan-keyshift tf-apply-keyshift tf-destroy-keyshift

tf-init-keyshift: ## TF init: keyshift VM
	terraform -chdir=$(TF_BASE)/keyshift init

tf-plan-keyshift: tf-init-keyshift ## TF plan: keyshift VM
	terraform -chdir=$(TF_BASE)/keyshift plan $(TF_OPTS)

tf-apply-keyshift: tf-init-keyshift ## TF apply: keyshift VM
	terraform -chdir=$(TF_BASE)/keyshift apply $(TF_OPTS)

tf-destroy-keyshift: ## TF destroy: keyshift VM (destructive)
	terraform -chdir=$(TF_BASE)/keyshift destroy $(TF_OPTS)

# ── Terraform: openclaw ───────────────────────────────────────────────────────
## ── Terraform — openclaw
.PHONY: tf-init-openclaw tf-plan-openclaw tf-apply-openclaw tf-destroy-openclaw

tf-init-openclaw: ## TF init: OpenClaw AI agent VM
	terraform -chdir=$(TF_BASE)/openclaw init

tf-plan-openclaw: tf-init-openclaw ## TF plan: OpenClaw AI agent VM
	terraform -chdir=$(TF_BASE)/openclaw plan $(TF_OPTS)

tf-apply-openclaw: tf-init-openclaw ## TF apply: OpenClaw AI agent VM
	terraform -chdir=$(TF_BASE)/openclaw apply $(TF_OPTS)

tf-destroy-openclaw: ## TF destroy: OpenClaw AI agent VM (destructive)
	terraform -chdir=$(TF_BASE)/openclaw destroy $(TF_OPTS)

# ── Utilities ─────────────────────────────────────────────────────────────────
## ── Utilities
.PHONY: ping lint tf-validate tf-fmt check-syntax clean

ping: ## Ping all hosts in inventory
	cd $(ANSIBLE_DIR) && ansible all -m ping $(ANSIBLE_OPTS)

check-syntax: ## Syntax-check all playbooks without running them
	cd $(ANSIBLE_DIR) && ansible-playbook --syntax-check playbooks/*.yml

lint: check-syntax tf-validate ## Run ansible syntax check + terraform validate on all deployments

tf-validate: ## Validate all Terraform deployments
	@for d in $(TF_BASE)/*/; do \
		printf "\033[36mValidating $$d...\033[0m\n"; \
		terraform -chdir=$$d init -backend=false -input=false -no-color > /dev/null 2>&1; \
		terraform -chdir=$$d validate && printf "\033[32m  OK\033[0m\n" || printf "\033[31m  FAIL\033[0m\n"; \
	done

tf-fmt: ## Format all Terraform files in-place
	terraform fmt -recursive terraform/

clean: ## Remove local .terraform dirs and crash logs
	find terraform/ -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null; \
	find terraform/ -name "crash.log" -delete 2>/dev/null; \
	find terraform/ -name ".terraform.lock.hcl" -delete 2>/dev/null; true
