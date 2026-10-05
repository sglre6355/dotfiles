{
  config,
  lib,
  pkgs,
  hostPlatform,
  ...
}:
{
  imports = [
    ../modules/home/common/zsh.nix
    ../modules/home/common/services/gpg-agent.nix

    ../modules/home/common/commands/bat.nix
    ../modules/home/common/commands/fzf.nix
    ../modules/home/common/commands/neovim.nix
    ../modules/home/common/commands/zellij.nix
    ../modules/home/common/commands/zoxide.nix

    ../modules/home/common/development/git.nix
    ../modules/home/common/development/gh.nix
    ../modules/home/common/development/herdr.nix

    ../modules/home/common/applications/firefox.nix
    ../modules/home/common/applications/wezterm.nix
  ]
  ++ lib.optionals hostPlatform.isLinux [
    ../modules/home/linux/xdg.nix
    ../modules/home/linux/applications/junction.nix
  ];

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  home.shellAliases = {
    tree = "${pkgs.tree}/bin/tree --gitignore";
  };

  programs.zsh.initContent = /* zsh */ ''
    # cd into a ghq-managed repository
    cdr() {
      local repo
      repo=$(ghq list --full-path | fzf --scheme=path) && cd "$repo"
    }

    # cd into a git-wt-managed worktree
    cdw() {
      local worktree
      worktree=$(git-wt --json | ${pkgs.jq}/bin/jq -r '.[].path' | fzf --scheme=path) && cd "$worktree"
    }

    # enable `git wt` directory switching
    eval "$(git-wt --init zsh)"
  '';

  home.packages = with pkgs; [
    btop
    fastfetch

    file
    jq
    ripgrep
    tealdeer
    timg
    tree

    gnumake

    ghq
    git-wt
    nh

    zip
    unzip
    unrar
  ];

  programs.home-manager.enable = true;
}
