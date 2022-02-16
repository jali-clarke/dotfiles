{ config, lib, ... }:
{
  config.programs.direnv = {
    enable = lib.mkDefault config.dotfiles.enableAll;
    nix-direnv.enable = true;
  };

  config.dotfiles.config = lib.mkIf config.programs.direnv.enable {
    "direnv/direnvrc" = config.lib.dotfiles.fromSimpleXDG config.xdg.configFile."direnv/direnvrc";
  };
}
