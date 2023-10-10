{ config, lib, ... }:

{
    services.xserver = {
        enable = true;

        # wm
        windowManager = {
            awesome = {
                enable = true;
            };
        };
        # dm
        displayManager = {
            enable = false;
        };

        # intel video drivers
        videoDrivers = [ "intel" ];

        videoDriversConfig.intel = {
            TearFree = true;
            TripleBuffer = true;
            DRI = "3";
            # AccelMethod = "sna";  # You can enable this if needed
            # AccelMethod = "uxa";  # older option
        };

        # keyboard
        xkbOptions = [
            "ctrl:nocaps"
            "lv3:ralt_switch"
        ];

        xkbOptions = lib.concatMapStringsSep " " (option: [
          "${option}:compose:ralt"
        ]) [ "a:adiaeresis", "u:udiaeresis", "o:odiaeresis", "s:ss" ];

        # monitors
        windowManager.xrandr.enable = true;
        windowManager.xrandr.outputSettings = {
          eDP1 = { resolution = "1920x1080"; };
        };
    };
}
