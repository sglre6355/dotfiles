# GitHub CLI
if type gh > /dev/null; then
    source <(gh completion -s zsh)
fi

# Arduino CLI
if type arduino-cli > /dev/null; then
    source <(arduino-cli completion zsh)
fi

# kubectl
if type kubectl > /dev/null; then
    source <(kubectl completion zsh | head -n -4)
fi

# Tailscale
if type tailscale > /dev/null; then
    source <(tailscale completion zsh | head -n -4)
fi

# Podman
if type podman > /dev/null; then
    source <(podman completion zsh | head -n -6)
fi

# rbw (Unofficial Bitwarden CLI)
if type rbw > /dev/null; then
    source <(rbw gen-completions zsh)
fi

# buf
if type buf > /dev/null; then
    source <(buf completion zsh | head -n -4)
fi

if type codex > /dev/null; then
    source <(codex completion zsh)
fi

if type atlas > /dev/null; then
    source <(atlas completion zsh)
fi
