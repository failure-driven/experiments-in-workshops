.DEFAULT_GOAL := usage

# user and repo
USER        = $$(whoami)
CURRENT_DIR = $(notdir $(shell pwd))

# terminal colours
RED     = \033[0;31m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
RESET   = \033[0m

define ANNOUNCE
echo "$(2)$(1)${RESET}"
endef

.PHONY: setup
setup:
	rvm install "ruby-3.2.2"
	bin/setup


.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${RESET} Welcome to ${RED}${CURRENT_DIR}${RESET}"
	@echo
	@echo "Getting started"
	@echo
	@echo "${YELLOW}make${RESET}                     this handy usage guide"
	@echo
	@echo "Development"
	@echo
	@echo "${YELLOW}make setup${RESET}               npm install and setup DB"
	@echo
