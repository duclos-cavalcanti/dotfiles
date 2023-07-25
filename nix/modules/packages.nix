{   pkgs, ... }:

let
    X11Packages = with pkgs; [
        xorg.xorg 
        xorg.xinit 
        xorg.xrandr 
        xorg.xset 
        xclip
        xvfb-run
    ]; 

    DriverPackages = with pkgs; [
        pulseaudio 
        networkmanager 
        wireless-tools 
        firmware-linux-nonfree
        bluez
        bluezPackages.bluezTools
        bluezPackages.bluezUtils
    ]; 

    BasePackages = with pkgs; [
        awesome
        firefox
        wezterm
        neovim
        stow
        fonts.ubuntu-fonts
    ]; 

    GoPackages = with pkgs;
    [
        gopls
        glow
        vhs
    ];

    RustPackages = with pkgs;
    [
        cargo 
        rustc
        rust-analyzer
        rustfmt
    ];

    LuaPackages = with pkgs;
    [
        lua
        lua-language-server
    ];


    PyPackages = with pkgs.python3Packages;
    [
        jupyter-notebook
        euporie 
        ipython 
        ipdb 
        ipykernel
        compiledb 
        pyright 
        pyls
    ];

    NdPackages = with pkgs.nodePackages; 
    [
        npm
        bash-language-server
        typescript
        typescript-language-server
        vscode-langservers-extracted
        cssmodules-language-server
    ];
in

{
    environment.systemPackages = with pkgs; [
        # X11
        X11Packages

        # Drivers
        DriverPackages

        # Base
        BasePackages 

        # Dev
        git
        gitui
        gnumake
        gcc
        gcc-arm-embedded
        gdb
        glibc
        cmake 
        ninja
        clang
        pandoc
        docker
        curl
        wget
        unzip
        fzf 
        fd
        ripgrep
        bat 
        exa
        tree
        jq
        yq
        cppcheck
        doxygen
        lcov
        valgrind

        python3 
        python3Packages.pip
        PyPackages

        go
        GoPackages

        nodejs
        NdPackages

        RustPackages

        LuaPackages

        # Hardware
        blueman
        arandr
        network-manager-applet
        NetworkManager-openvpn
        pasystray
        pavucontrol

        # Desktop
        spotify
        nitrogen
        unclutter
        maim
        ffmpeg-full
        neomutt
        password-store
        evince
        gnome.gedit
        gnome.nautilus
        gnome.eog
        gnome.gnome-disk-utility
        gnome.totem
        gnome.cheese
        baobab
        gcolor3
        gimp
        galculator
        xscreensaver
        themechanger
        mate.mate-themes
        mate.mate-icon-theme
        arc-theme
        arc-icon-theme
    ];
}
