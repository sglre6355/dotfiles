{
  llmAgentsPkgs,
  pkgs,
  ...
}:
{
  programs.opencode = {
    enable = true;
    package = pkgs.symlinkJoin {
      inherit (llmAgentsPkgs.opencode2) pname version;
      paths = [ llmAgentsPkgs.opencode2 ];
      postBuild = ''
        mv $out/bin/opencode2 $out/bin/opencode
      '';
      meta = llmAgentsPkgs.opencode2.meta // {
        mainProgram = "opencode";
      };
    };
    skills = {
      herdr = "${pkgs.herdr.src}/skills/herdr/SKILL.md";
    };
  };
}
