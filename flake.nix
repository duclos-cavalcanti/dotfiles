{
    description = "Daniel Cavalcanti's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
                    ./modules/base.nix 
                    ./modules/hardware.nix
                    ./modules/x11.nix
                    ./modules/packages.nix

                    # home-manager.nixosModules.home-manager {
                    #   home-manager.useGlobalPkgs = true;
                    #   home-manager.useUserPackages = true;
                    #   home-manager.users.jdoe = import ./home.nix;
                    #
                    # }
                ];
            };
        };
    };
}
