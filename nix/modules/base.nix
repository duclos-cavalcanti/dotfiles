{   config, lib, pkgs, ... }:

{
    i18n = {
      consoleFont = "Ubuntu Mono";
      consoleKeyMap = "us";
      defaultLocale = "en_US.UTF-8";
    };

    networking.hostName = "nix-think"
}
