{ config, lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  config.lib.dotfiles-with-targets.fromSimpleXDG = xdgConfigFile: {
    contents = xdgConfigFile.text;
    file = xdgConfigFile.source;
    target = "${config.home.homeDirectory}/${xdgConfigFile.target}";
  };

  options.dotfiles-with-targets = mkOption {
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
}
