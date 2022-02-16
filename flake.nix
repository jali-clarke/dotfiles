{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager/release-21.11";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.flake-templates.url = "github:jali-clarke/flake-templates";

  outputs = flakeInputs@{ self, nixpkgs, home-manager, flake-templates }: {
    lib = rec {
      homeManagerModule = import ./configs flakeInputs;
      builtHomeManagerModule =
        { system
        , username
        , homeDirectory
        , configuration ? { }
        , pkgs ? import nixpkgs { inherit system; }
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit system username homeDirectory pkgs;
          configuration = { imports = [ homeManagerModule configuration ]; };
        };
    };
  };
}
