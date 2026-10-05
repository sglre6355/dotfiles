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
    ../modules/home/common/gpg-agent.nix

    ../modules/home/common/bat.nix
    ../modules/home/common/fzf.nix
    ../modules/home/common/neovim.nix
    ../modules/home/common/zellij.nix
    ../modules/home/common/zoxide.nix

    ../modules/home/common/git.nix
    ../modules/home/common/gh.nix
    ../modules/home/common/herdr.nix

    ../modules/home/common/firefox.nix
    ../modules/home/common/wezterm.nix
  ]
  ++ lib.optionals hostPlatform.isLinux [
    ../modules/home/linux/xdg.nix
    ../modules/home/linux/junction.nix
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
