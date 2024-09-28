export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR=nvim
export PATH="$PATH:$HOME/.local/bin"

# GPG
export GPG_TTY=$(tty)

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
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"

# Firefox
export MOZ_ENABLE_WAYLAND=1
