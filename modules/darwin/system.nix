{
  username,
  ...
}:
{
  system.primaryUser = username;

  system.defaults = {
    dock.autohide = true;
    NSGlobalDomain.KeyRepeat = 2;
  };
}
