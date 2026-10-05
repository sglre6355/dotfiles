{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    devenv
  ];

  programs.direnv = {
    enable = true;
    # nix-direnv 3.2.0 touches the watched flake-profile-*.rc on every load,
    # so shells sharing a project keep reloading each other.
    # TODO: drop this once a release includes nix-community/nix-direnv#790
    stdlib = ''
      _nix_refresh_gcroots() {
        local d
        d=$(direnv_layout_dir)
        touch -h "$d"/flake-profile-*[!c] "$d"/flake-inputs/* "$d"/nix-profile-* 2>/dev/null
      }
    '';
  };
}
