
MAKEFLAGS += -rR

SHELL = /bin/bash


.PHONY: update gen-readme HELP
.DEFAULT_GOAL = help


help:
	@echo -e ".vim Files\nTargets:"
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'




update: ## - Update submodules
	@echo "[i] Updating vim submodules:"
	@git submodule update --init --recursive
	@git submodule foreach git pull --recurse-submodules -q origin master

gen-readme: ## - Generate submodule list for readme.md
	@for GR in $(shell git submodule --quiet foreach git config --get remote.origin.url); do \
		SN=$$(echo $$GR| sed 's#https://##' | sed 's#git://##' | sed 's/.git//'); \
		echo " * [$$SN]($$GR)"; \
	done; \

