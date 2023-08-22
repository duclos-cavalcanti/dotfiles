{
    description = "Daniel Cavalcanti's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follos = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }: {
        let 
            system = "x86_64-linux";
        in {
            homeConfigurations."duclos" = home-manager.lib.homeManagerConfigurations {
                modules = [
                    ./modules/base.nix 
                    ./modules/hardware.nix
                    ./modules/x11.nix
                    ./modules/packages.nix
                ];
            }
        }
    };
}
