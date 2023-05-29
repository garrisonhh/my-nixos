{
  description = "garrisonhh's nixos";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager.url = github:nix-community/home-manager/release-23.05;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      systemName = "ghh-laptop";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in {
      nixosConfigurations = {
        ${systemName} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
    };
}