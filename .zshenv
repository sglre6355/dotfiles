export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CURRENT_DESKTOP=sway
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR=nvim
export BROWSER=firefox
export PATH="$PATH:$HOME/.local/bin"

# Python
export PYTHONDONTWRITEBYTECODE=1

# Android
export ANDROID_SDK_ROOT="$HOME/android/sdk"
export ANDROID_CMD_LINE_TOOLS="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_PLATFORM_TOOLS="$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/emulator";

# Flutter
export PATH="$PATH:$HOME/flutter/bin"

# Input method modules
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"

# Firefox
export MOZ_ENABLE_WAYLAND=1

export DOCKER_HOST='unix:///var/run/docker.sock'

# Go
export PATH="$PATH:$(go env GOPATH)/bin"

export PATH=/home/sglre6355/.tiup/bin:$PATH

# Java
export _JAVA_AWT_WM_NONREPARENTING=1
