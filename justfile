# just file for managing this repo with just
# more info:
#   - https://github.com/casey/just
#   - https://just.systems/man/en/

# need bash on GHActions `just --shel bash`
set shell := ["zsh", "-uc"]

# user and repo
user        := `whoami`
current_dir := `basename $( pwd )`

# Colors
RED     := "\\u001b[31m"
GREEN   := "\\u001b[32m"
YELLOW  := "\\u001b[33m"
BLUE    := "\\u001b[34m"
MAGENTA := "\\u001b[35m"
BOLD    := "\\u001b[1m"
RESET   := "\\u001b[0m"

_default:
    @echo "\nHi {{GREEN}}{{user}}!{{RESET}} Welcome to {{RED}}{{current_dir}}{{RESET}}\n"

    @just --list --unsorted

# check required tools
install:
    brew bundle

# brings in `just demo-ai` as well as `just _tumx-down` as part of cleanup
# TODO: is there a better way to import files and fire after `clean` hooks?
import "bin/just/ai-demo.just"

#
# clean
#
# 🧹 cleanup tasks
clean: _tmux-down

## Hidden recipies

_announce message color:
    #!/usr/bin/env zsh
    echo -e "{{color}}{{message}}{{RESET}}"

