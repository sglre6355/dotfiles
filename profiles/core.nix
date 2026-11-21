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
    ../modules/home/common/zellij.nix
    ../modules/home/common/zoxide.nix

    ../modules/home/common/git.nix
    ../modules/home/common/gh.nix
    ../modules/home/common/herdr.nix
  ]
  ++ lib.optionals hostPlatform.isLinux [
    ../modules/home/linux/xdg.nix
  ];

  programs.nixvim.enable = true;

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  home.shellAliases = {
    tree = "${lib.getExe pkgs.tree} --gitignore";
  };

  programs.zsh.initContent = /* zsh */ ''
    # cd into a ghq-managed repository
    cdr() {
      local repo
      repo=$(${lib.getExe pkgs.ghq} list --full-path | ${lib.getExe config.programs.fzf.package} --scheme=path) && cd "$repo"
    }

    # cd into a git-wt-managed worktree
    cdw() {
      local worktree
      worktree=$(${lib.getExe pkgs.git-wt} --json | ${lib.getExe pkgs.jq} -r '.[].path' | ${lib.getExe config.programs.fzf.package} --scheme=path) && cd "$worktree"
    }

    # enable `git wt` directory switching
    eval "$(${lib.getExe pkgs.git-wt} --init zsh)"
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
