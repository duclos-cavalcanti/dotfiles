{
    description = "Daniel Cavalcanti's NixOS configuration";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    outputs = { self, nixpkgs }: {
        nixosConfigurations.nix-think = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            ./modules/base.nix 
            ./modules/hardware.nix
            ./modules/x11.nix
            ./modules/packages.nix
        ];
    };
  };
}
