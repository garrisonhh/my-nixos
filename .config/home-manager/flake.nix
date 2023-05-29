{
  description = "garrison's home manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
  };

  outputs = { nixpkgs, home-manager, prismlauncher, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.garrison = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];

        extraSpecialArgs = {
          inherit prismlauncher;
        };
      };
    };
}