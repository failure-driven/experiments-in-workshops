# Makefile

```sh
cat << EO_MAKEFILE > Makefile
default: usage

.PHONY: install
install:
	bundle

.PHONY: test
test:
	bundle exec rspec

.PHONY: lint
lint:
	bundle exec rubocop

.PHONY: lint-fix
lint-fix:
	bundle exec rubocop -A

.PHONY: build
build: install test lint demo

.PHONY: demo
demo:
	bin/run.rb arg_1 arg_2

.PHONY: usage
usage:
	@echo "make                 this handy usage guide"
	@echo
	@echo "make install         install via bundle and brew"
	@echo "make test            run rspec tests"
	@echo "make lint            run rubocop linting"
	@echo "make lint-fix        run rubocop autocorrect"
	@echo "make build           run full build, test, lint and demo"
	@echo
	@echo "make demo            run the demo"
EO_MAKEFILE

make
make build
make demo
```
