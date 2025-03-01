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

.PHONY: setup-ruby
setup-ruby:
	# TODO: check not installed
	rvm install "ruby-3.2.2"

.PHONY: setup-chrome
setup-chrome:
	# TODO: check not installed
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | \
		sudo tee /etc/apt/sources.list.d/google-chrome.list
	sudo apt-get update
	sudo apt-get install google-chrome-stable

.PHONY: setup
setup: setup-ruby setup-chrome
	bin/setup

.PHONY: test
test:
	bin/rspec

.PHONY: run
run:
	bin/rails server

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
	@echo "${YELLOW}make setup${RESET}               setup dependancies"
	@echo "${YELLOW}make test${RESET}                run tests"
	@echo "${YELLOW}make run${RESET}                 run the app"
	@echo
