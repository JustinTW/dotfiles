.PHONY: help base web moxa debug backup pref-backup lint
.DEFAULT_GOAL := help

SHELL_SCRIPTS := scripts/install scripts/backup scripts/osx-backup-pref \
                 $(wildcard scripts/libs/*) $(wildcard scripts/stack/*/*/*)

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-14s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

base: ## Provision the base environment
	@./scripts/install base

web: ## Install the web development stack
	@./scripts/install web

moxa: ## Install the Moxa enterprise stack
	@./scripts/install moxa

debug: ## Re-apply sudo config and dotfile symlinks only
	@./scripts/install debug

backup: ## rsync home and the DATA volume to the external backup volume
	@./scripts/backup

pref-backup: ## Export macOS preference domains to ~/Desktop
	@./scripts/osx-backup-pref backup

lint: ## Run shellcheck over every shell script
	@shellcheck $(SHELL_SCRIPTS)
