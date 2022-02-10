{ config, lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./vscode
    ./zsh.nix
  ];

  config.lib.dotfiles.fromSimpleXDG = xdgConfigFile: {
    contents = xdgConfigFile.text;
    file = xdgConfigFile.source;
    target = "${config.home.homeDirectory}/${xdgConfigFile.target}";
  };

  options.dotfiles = {
    enableAll = mkOption {
      type = types.bool;
      default = false;
    };

    config = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            contents = mkOption {
              type = types.lines;
            };

            file = mkOption {
              type = types.path;
            };

            target = mkOption {
              type = types.path;
            };
          };
        }
      );
    };
  };
}
