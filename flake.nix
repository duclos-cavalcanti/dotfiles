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
                    ./modules/home.nix 

                    # ./modules/base.nix 
                    # ./modules/hardware.nix
                    # ./modules/x11.nix
                    # ./modules/packages.nix
                ];
            };
        };
    };
}
