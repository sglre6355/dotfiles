{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    veracrypt
  ];

  home.shellAliases = {
    veracrypt = "${lib.getExe' pkgs.veracrypt "veracrypt"} -t";
  };
}
