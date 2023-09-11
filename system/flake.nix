{
  description = "garrisonhh's nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, zig, ... }:
    let
      system = "x86_64-linux";
      systemName = "ghh-laptop";

      pkgs = (import nixpkgs) {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          zig.overlays.default
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
