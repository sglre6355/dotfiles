{
  config,
  lib,
  ...
}:
{
  home.shellAliases = {
    cat = "${lib.getExe config.programs.bat.package} -pP";
  };

  programs.bat = {
    enable = true;
  };
}
