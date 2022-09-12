{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager/master";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.flake-templates.url = "github:jali-clarke/flake-templates";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = flakeInputs@{ self, nixpkgs, home-manager, flake-templates, flake-utils }: {
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
  } // flake-utils.lib.eachDefaultSystem (
    system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nixpkgs-fmt
        ];
      };
    }
  );
}
