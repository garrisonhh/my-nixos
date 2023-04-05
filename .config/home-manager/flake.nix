{
  description = "garrison's home manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.garrison = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];
      };
    };
}