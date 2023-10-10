{   config, lib, pkgs, ... }:

{
    i18n = {
      consoleFont = "Ubuntu Mono";
      consoleKeyMap = "us";
      defaultLocale = "en_US.UTF-8";
    };

    networking.hostName = "nix-think"

    users.users = {
       # Define your primary user account
       duclos = {
            isNormalUser = true;
            uid = 1000;
            home = "/home/duclos";
            extraGroups = [ "wheel" "networkmanager" ];  # Additional groups the user belongs to
            createHome = true;
            shell = pkgs.bash;
            hashedPassword = lib.mkForce (lib.mkpasswd (builtins.readLine "Enter the chosen password: "));
       };
     };
}
