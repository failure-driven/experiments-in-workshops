#
# tmux demo
#
# bring tmux up
_tmux-up:
    tmux -L "demo-ai" new-session -d

# attach to running tmux session
_tmux-attach:
    tmux -L "demo-ai" -CC attach-session

# kill tmux session
@_tmux-down:
    tmux -L "demo-ai" list-sessions > /dev/null && \
        tmux -L "demo-ai" kill-session || \
        just _announce "all tmux sessions killed ☠️ " "{{GREEN}}"

# start ollama and mistral
_tmux-ollama-start:
    tmux -L "demo-ai" new-window -d -n 1 -t "0:1"
    tmux -L "demo-ai" send-keys -t "0:1" "ollama serve" Enter
    tmux -L "demo-ai" rename-window -t "0:1" "ollama"
    tmux -L "demo-ai" new-window -d -n 2 -t "0:2"
    tmux -L "demo-ai" rename-window -t "0:2" "mistral"
    tmux -L "demo-ai" send-keys -t "0:2" "just _ollama-up" Enter
    tmux -L "demo-ai" send-keys -t "0:2" "ollama run mistral" Enter
    sleep 2
    tmux -L "demo-ai" send-keys -t "0:2" "It's a great day to" Enter

# check if ollama is up
@_ollama-up:
    just _announce "waiting ♾️  till ollama is 🆙" "{{YELLOW}}"
    until ollama ps >> /dev/null 2>&1; do echo -n "."; sleep 1; done
    just _announce "🚀 ollama up" "{{GREEN}}"

# demo ollama AI
demo-ai: _tmux-up _tmux-ollama-start _tmux-attach
