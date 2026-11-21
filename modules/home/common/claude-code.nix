{
  lib,
  llmAgentsPkgs,
  pkgs,
  ...
}:
{
  programs.claude-code = {
    enable = true;
    package = llmAgentsPkgs.claude-code;
    mutableSettings = true;
    settings = {
      statusLine = {
        type = "command";
        command = lib.getExe llmAgentsPkgs.ccstatusline;
        padding = 0;
      };
      attribution = {
        commit = "";
        pr = "";
        sessionUrl = false;
      };
    };
    skills = {
      herdr = "${pkgs.herdr.src}/skills/herdr/SKILL.md";
    };
  };
}
