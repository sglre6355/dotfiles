{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    git
    gnupg
    home-manager
    neovim
    sbctl
  ];

  nixpkgs.config.allowUnfree = true;
}
