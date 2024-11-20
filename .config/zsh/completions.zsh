# GitHub CLI
if type gh > /dev/null; then
    eval "$(gh completion -s zsh)"
fi

# Arduino CLI
if type arduino-cli > /dev/null; then
    eval "$(arduino-cli completion zsh)"
fi

# kubectl
if type kubectl > /dev/null; then
    eval "$(kubectl completion zsh | head -n -4)"
fi

# Tailscale
if type tailscale > /dev/null; then
    eval "$(tailscale completion zsh | head -n -4)"
fi
