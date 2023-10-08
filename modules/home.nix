{ config, pkgs, ... }:

{
  home.username = "duclos";
  home.homeDirectory = "/home/duclos";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
