{
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
        command = "${llmAgentsPkgs.ccstatusline}/bin/ccstatusline";
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
