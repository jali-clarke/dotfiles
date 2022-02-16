flakeInputs:
{ config, lib, ... }:
{
  config = lib.mkIf config.dotfiles.useNixRegistry {
    nix.registry = {
      nixpkgs = {
        exact = true;
        from = {
          type = "indirect";
          id = "nixpkgs";
        };
        to = {
          type = "github";
          owner = "NixOS";
          repo = "nixpkgs";
          rev = flakeInputs.nixpkgs.rev;
        };
      };

      templates = {
        exact = true;
        from = {
          type = "indirect";
          id = "templates";
        };
        to = {
          type = "github";
          owner = "jali-clarke";
          repo = "flake-templates";
          rev = flakeInputs.flake-templates.rev;
        };
      };
    };

    dotfiles.config = {
      "nix/registry" = config.lib.dotfiles.fromSimpleXDG config.xdg.configFile."nix/registry.json";
    };
  };
}
