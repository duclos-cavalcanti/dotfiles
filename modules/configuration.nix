{ config, pkgs, ... }

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.canTouchEfiVariables = true;

    time.timeZone = "America/New_York"

    i18n = {
        defaultLocale = "en_US.UTF-8";
        console = {
          font = "Ubuntu Mono";
          KeyMap = "us";
          useXkbConfig = true;
        }
    };

    networking.networkmanager.enable = true;
    networking.hostname = "nixos"

    users.users = {
       duclos = {
            isNormalUser = true;
            uid = 1000;
            home = "/home/duclos";
            extraGroups = [ "wheel" "networkmanager" ];  # Additional groups the user belongs to
            createHome = true;
            shell = pkgs.bash;
       };
     };

    services.xserver = {
        enable = true;
        # wm
        windowManager = {
            awesome = {
                enable = true;
            };
        };
        # monitors
        windowManager.xrandr.enable = true;
        windowManager.xrandr.outputSettings = {
          eDP1 = { resolution = "1920x1080"; };
        };
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;
    services.xserver.libinput.enable = true;

    services.openssh.enable = true;

    programs.gnupg.agent = {
        enable = ture;
        enableSSHSupport = true;
    };

    system.stateVersion = "23.05";
}
