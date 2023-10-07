{
    description = "Daniel Cavalcanti's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, ... }: {
        nixosConfigurations = {
            hostname = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.username = "duclos";
                        home-manager.homeDirectory = "/home/duclos";
                        home-manager.stateVersion = "23.05";
                        programs.home-manager.enable = true;
                    }

                    ./modules/base.nix 
                    ./modules/hardware.nix
                    ./modules/x11.nix
                    ./modules/packages.nix
                ];

            }
        }
    };
}
