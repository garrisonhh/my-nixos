{
  description = "garrisonhh's nixos";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, zig, prismlauncher, ... }:
    let
      system = "x86_64-linux";
      systemName = "ghh-laptop";

      pkgs = (import nixpkgs) {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          zig.overlays.default
          prismlauncher.overlay
        ];
      };
    in {
      nixosConfigurations = {
        ${systemName} = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [ ./configuration.nix ];
        };
      };
    };
}