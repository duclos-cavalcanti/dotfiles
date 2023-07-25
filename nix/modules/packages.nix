{   pkgs, ... }:

let
  PyPackages = with pkgs.python3Packages;
  [
    tensorflow
    numpy
    pandas
    compiledb 
    pyright 
    ipython 
    ipdb 
    pyls
    euporie 
    ipykernel
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
    # Set your desired list of packages
    environment.systemPackages = with pkgs; [
        # X11
        xorg.xorg 
        xorg.xinit 
        xorg.xrandr 
        xorg.xset 
        xclip
        xvfb-run
        # Fonts
        fonts.ubuntu-fonts
        # Base
        awesome
        firefox
        wezterm
        neovim
        stow
        # Dev
        git
        gnumake
        gcc
        gcc-arm-embedded
        gdb
        glibc
        curl
        wget
        unzip
        python3 
        python3Packages.pip
        python3.10-notebook
        go
        gopls
        glow
        vhs
        nodejs
        fzf 
        fd
        ripgrep
        bat 
        exa
        tree
        cmake 
        ninja
        clang
        cppcheck
        doxygen
        lcov
        valgrind
        lua
        lua-language-server
        pandoc
        docker
        jq
        yq
        cargo 
        rustc
        rust-analyzer
        rustfmt
        gitui
        # Hardware
        blueman
        bluez
        arandr
        networkmanager
        network-manager-applet
        NetworkManager-openvpn
        pulseaudio
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
    ] ++ PyPackages ++ NdPackages;
}
