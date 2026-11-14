{
  llmAgentsPkgs,
  pkgs,
  ...
}:
{
  programs.opencode = {
    enable = true;
    package = llmAgentsPkgs.opencode2;
    skills = {
      herdr = "${pkgs.herdr.src}/skills/herdr/SKILL.md";
    };
  };
}
