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

.PHONY: npm-install
npm-install:
	npm install

.PHONY: install
install: npm-install
	brew bundle

.PHONY: prisma-migrate
prisma-migrate:
	npx prisma migrate dev

.PHONY: setup
setup: npm-install prisma-migrate

.PHONY: test-unit
test-unit:
	npm test -- --run

.PHONY: test-e2e
test-e2e:
	# issue if it is running or takes too long to start or PORT is taken
	# TODO: force PORT to be 1 port and only that port
	# TODO: how to run in test environment with a different DB?
	npm run dev &
	NEXTJS_DEV_PID=$!
	echo ${NEXTJS_DEV_PID}
	# npm run cypress:run
	#kill ${NEXTJS_DEV_PID}
	#pkill node_modules/.bin/next
	# TODO: wait for last thing to finish?
	# sleep 10
	# TODO: wait for server to be up
	sleep 1
	curl http://localhost:3000/seed && \
		npm run cypress:run && \
		lsof -t -i:3000 | \
		xargs -I {} ps aux {} | \
		ag next-server | \
		awk '{print $$2}' | \
		xargs kill -9
	# TODO: attempt to kill all other started test servers on different ports
	# ps aux | ag next-server | awk '{print $2}' | xargs kill -9

.PHONY: cypress-open
cypress-open:
	npm run cypress:open -- --browser chrome --e2e

.PHONY: lint
lint:
	npm run lint
	npm run prettier

.PHONY: lint-fix
lint-fix:
	npm run lint -- --fix
	npm run prettier:fix
	npx prisma format

.PHONY: test
test: test-unit test-e2e

.PHONY: build
build: npm-install test lint
	npm run build

.PHONY: demo-worker
demo-worker:
	npm run worker:sample

.PHONY: demo-app
demo-app:
	npm run dev

.PHONY: ollama-up
ollama-up:
	ollama serve

.PHONY: ollama-mistral-up
ollama-mistral-up:
	ollama run mistral

##
# TMUX to rule the world 🌏
#
# start TMUX in server socket mode
tmux-up:
	tmux -L "dev" new-session -d

# start TMUX for the full experience 🛋️
.PHONY: tmux-all-the-things.
tmux-all-the-things: tmux-up
	@tmux -L "dev" new-window -d -n 'guestbook' -t "0:2"
	@tmux -L "dev" send-keys -t "0:2" 'make demo-app' Enter
	@tmux -L "dev" new-window -d -n 'BullMQ' -t "0:3"
	@tmux -L "dev" send-keys -t "0:3" 'make demo-worker' Enter
	@tmux -L "dev" new-window -d -n 'shell' -t "0:4"
	@tmux -L "dev" send-keys -t "0:4" 'make' Enter
	@tmux -L "dev" -CC attach-session

.PHONY: tmux-reattach
tmux-reattach:
	tmux -L "dev" -CC attach-session

.PHONY: tmux-down
tmux-down:
	tmux -L "dev" kill-session

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
	@echo "${YELLOW}make test-unit${RESET}           run Unit tests"
	@echo "${YELLOW}make test-e2e${RESET}            run E2E tests"
	@echo "${YELLOW}make lint${RESET}                lint the code"
	@echo "${YELLOW}make build${RESET}               run build against tests and linting"
	@echo
	@echo "Demo"
	@echo
	@echo "${YELLOW}make demo-app${RESET}            run rubocop with TODOs"
	@echo "${YELLOW}make demo-worker${RESET}         run rubocop with TODOs"
	@echo
	@echo "AI"
	@echo
	@echo "${YELLOW}make install${RESET}             install ollama (via brew)"
	@echo "${YELLOW}make ollama-up${RESET}           run ollama"
	@echo "${YELLOW}make ollama-mistral-up${RESET}   run mistral on ollama"
	@echo
	@echo "Demo"
	@echo
	@echo "${YELLOW}make tmux-all-the-things${RESET} run rubocop with TODOs"
