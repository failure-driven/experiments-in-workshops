# justfile - rather than make

```sh
brew install just

cat << EO_JUSTFILE > justfile
_default:
    @just --list --unsorted

# install via bundle and brew
install:
    brew install just
    bundle

# run rspec tests
test:
    bundle exec rspec

# run rubocop linting
lint:
    bundle exec rubocop

# run rubocop autocorrect
lint-fix:
    bundle exec rubocop -A

# run full build, test, lint and demo
build: install test lint demo

# run the demo
demo:
    bin/run.rb arg_1 arg_2
EO_JUSTFILE

just
just build
just demo
```
