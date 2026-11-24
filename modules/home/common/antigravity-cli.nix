{
  llmAgentsPkgs,
  pkgs,
  ...
}:
{
  programs.antigravity-cli = {
    enable = true;
    package = llmAgentsPkgs.antigravity-cli;
    skills = {
      herdr = "${pkgs.herdr.src}/skills/herdr/SKILL.md";
    };
  };
}
