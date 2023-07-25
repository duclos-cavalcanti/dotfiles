{   config, lib, ... }:

{
    services.xserver = {
        enable = true;
        windowManager = {
            awesome = {
                enable = true;
            };
        };
        displayManager = {
            enable = false;
        };
    };

    services.xserver.windowManager.xrandr.enable = true;
    services.xserver.windowManager.xrandr.outputSettings = {
      eDP1 = { resolution = "1920x1080"; };
    };
}

