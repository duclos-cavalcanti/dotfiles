{
    description = "Daniel Cavalcanti's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
    let 
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config = { allowUnfree = true; };
        };
    in
    {
        duclos = home-manager.lib.homeManagerConfiguration {
            inherit system pkgs;
            username = "duclos";
            homeDirectory = "/home/duclos";
            configuration = {
                imports = [
                    "./modules/home.nix"
                ];
            };
        };

        nixosConfigurations = {
            default = nixpkgs.lib.nixosSystem {
                inherit system;

                modules = [
                    ./modules/base.nix 
                    ./modules/packages.nix

                    # ./modules/base.nix 
                    # ./modules/hardware.nix
                    # ./modules/x11.nix
                    # ./modules/packages.nix
                ];
            };
        };
    };
}
