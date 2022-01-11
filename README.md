# dotfiles

my dotfiles, as a (collection of) [home-manager](https://github.com/nix-community/home-manager) module(s).  `program.x.enable` options are intentionally omitted; installation of things should be explicitly opt-in

## example usage

```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager/release-21.05";
  inputs.dotfiles.url = "github:jali-clarke/dotfiles";
  # can also have inputs.home-manager.follows = "dotfiles/home-manager";

  outputs = { self, nixpkgs, home-manager, dotfiles, ... }:
    {
      nixosConfigurations = {
        hostname = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # or whatever
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.your-user-name = dotfiles.lib.homeManagerModule;
              # can also do:
              # home-manager.users.your-user-name = import ./path/to/home.nix;
              # and in home.nix, have an imports for dotfiles.lib.homeManagerModule
            }
          ];
        };
      };

      # also works with darwinConfigurations.<hostname> and nix-darwin.lib.darwinSystem
    };
}
```
