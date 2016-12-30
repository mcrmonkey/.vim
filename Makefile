
MAKEFLAGS += -rR

SHELL = /bin/bash


PHONY := update gen-readme HELP

HELP:
	@echo -en "\n.vim Files\n\nrun:\nmake update\t-\tupdates all the submodules\nmake gen-readme\t-\tgenerate text needed for the plugins section of the readme.\n\n"




update:
	@echo ".vim: Updating vim submodules:"
	@git submodule update --init --recursive
	@git submodule foreach git pull --recurse-submodules -q origin master

gen-readme:
	@for GR in $(shell git submodule --quiet foreach git config --get remote.origin.url); do \
		SN=$$(echo $$GR| sed 's#https://##' | sed 's#git://##' | sed 's/.git//'); \
		echo " * [$$SN]($$GR)"; \
	done; \

