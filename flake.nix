{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/21.11";

  inputs.home-manager.url = "github:nix-community/home-manager/release-21.11";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, home-manager }: {
    lib = rec {
      homeManagerModule = import ./configs;
      builtHomeManagerModule =
        {
          system,
          username,
          homeDirectory,
          configuration ? {},
          pkgs ? import nixpkgs { inherit system; }
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit system username homeDirectory pkgs;
          configuration = configuration // { imports = [ homeManagerModule ]; };
        };
    };
  };
}
