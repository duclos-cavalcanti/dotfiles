{   config, pkgs, ... }:

{
    imports = [
        ./modules/base.nix 
        ./modules/hardware.nix
        ./modules/x11.nix
        ./modules/packages.nix
    ];
}
