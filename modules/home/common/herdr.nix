{
  pkgs,
  ...
}:
{
  # The agent integration hooks installed by herdr run python3.
  home.packages = [ pkgs.python3 ];

  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;

      theme = {
        name = "rose-pine";
        auto_switch = false;
      };

      ui = {
        agent_panel_sort = "spaces";
      };

      keys = {
        open_worktree = "prefix+shift+o";
        next_workspace = "ctrl+tab";
        previous_workspace = "ctrl+shift+tab";
        next_tab = "ctrl+`";
        previous_tab = "ctrl+shift+`";
      };

      experimental = {
        pane_history = false;
      };
    };
  };
}
