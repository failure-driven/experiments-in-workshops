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
	@echo "checking if ruby 3.2.2 is installed" + \
		"otherwise will attempt to use ${GREEN}rvm${RESET} to install."
	@ruby -v | grep 3.2.2 || \
		rvm install "ruby-3.2.2" && \
		echo "ruby 3.2.2 installed"

.PHONY: setup-chrome
setup-chrome:
	# TODO: check not installed
	# check on MacOS
	# mdfind "kMDItemKind == 'Application'" | grep "Google Chrome"
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | \
		sudo tee /etc/apt/sources.list.d/google-chrome.list
	sudo apt-get update
	sudo apt-get install google-chrome-stable

.PHONY: install
install:
	@command -v brew > /dev/null && \
		( \
			echo "${GREEN}✅ brew installed${RESET}" && \
			brew bundle \
		) || \
		echo "${YELLOW}no brew - you on your own${RESET}"

.PHONY: setup
setup: setup-ruby setup-chrome
	bin/setup

.PHONY: test
test:
	bin/rspec

.PHONY: lint
lint:
	bundle exec rubocop

.PHONY: lint-fix
lint-fix:
	bundle exec rubocop -A

.PHONY: build
build: test
	bundle exec rubocop

.PHONY: run
run:
	bin/rails server

.PHONY: demo-generate_text
demo-generate_text:
	bin/rails runner 'gen = AITextGenerator; \
		puts gen.generate_text(ARGV.join(" "))' \
		I love the testing Dem and in pARticular how to getting started with testing

.PHONY: demo-generate_text-ollama
demo-generate_text-ollama:
	TEXT_GENERATOR=OllamaAIGenerator make demo-generate_text

.PHONY: demo-generate_text-openai
demo-generate_text-openai:
	TEXT_GENERATOR=OpenAIGenerator make demo-generate_text

.PHONY: ollama-up
ollama-up:
	ollama serve

.PHONY: ollama-mistral-up
ollama-mistral-up:
	ollama run mistral

.PHONY: demo-ollama-mistral
demo-ollama-mistral:
	@echo "make install"
	@echo "make ollama-up"
	@echo "make ollama-mistral-up"
	@echo "make demo-generate_text-ollama"

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
