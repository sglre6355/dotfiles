{
  ...
}:
{
  homebrew = {
    enable = true;

    taps = [
      {
        name = "dimentium/autoraise";
        trusted = true;
      }
      {
        name = "nikitabobko/tap";
        trusted = true;
      }
    ];

    casks = [
      "autoraiseapp"
      "docker-desktop"
      "nikitabobko/tap/aerospace"
      "karabiner-elements"
    ];
  };
}
