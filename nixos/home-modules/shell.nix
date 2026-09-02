{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      la = "ls -la";
      ll = "ls -l";
    };
  };
  programs.zoxide.enable = true;
}
