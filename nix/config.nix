{
  description = "System flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs@{ nixpkgs, home-manager, self }: let
    username = "muscaln";
    mkSystemConfig = import ./lib/mkSystemConfig.nix;
  in {
    nixosConfigurations."g5070" = mkSystemConfig "g5070" {
      inherit username nixpkgs home-manager self;
      system = "x86_64-linux";
      modules = [
        ./modules/bluetooth.nix
        ./modules/pipewire.nix
        ./modules/xfce.nix
        ./modules/lightdm.nix
        ./modules/services.nix
        ./modules/packages.nix
      ];
    };

    nixosConfigurations."travelmate" = mkSystemConfig "travelmate" {
      inherit username nixpkgs home-manager self;
      system = "x86_64-linux";
      modules = [
        ./modules/bluetooth.nix
        ./modules/pipewire.nix
        ./modules/xfce.nix
        ./modules/plasma.nix
        ./modules/services.nix
        ./modules/packages.nix
      ];
    };
  };
}
