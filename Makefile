
MAKEFLAGS += -rR
SHELL = /bin/bash

.PHONY: update-all update/pathogen update/plugins readme help
.DEFAULT_GOAL = help

help:
	@echo -e ".vim Files\nTargets:"
	@awk 'BEGIN {FS = ":.*?##"} /^[a-zA-Z_-\/]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n",$$1, $$2}' $(MAKEFILE_LIST)

update-all: update/pathogen update/plugins ## - Update everything

update/pathogen: ## - Updates pathogen.
	@echo "[i] Updating Pathogen"
	@curl -LSso $(CURDIR)/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

update/plugins: ## - Update submodules
	@echo "[i] Updating vim submodules:"
	@git submodule update --init --recursive
	@git submodule update --remote
	@git submodule foreach 'git pull --recurse-submodules -q origin `git rev-parse --abbrev-ref HEAD`'

readme: ## - Generate submodule list for readme.md
	@for GR in $(shell git submodule --quiet foreach git config --get remote.origin.url); do \
		SN=$$(echo $$GR| sed 's#https://##' | sed 's#git://##' | sed 's/.git//'); \
		echo " * [$$SN]($$GR)"; \
	done; \

