{ config, ... }:
{
  config.programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  config.dotfiles-with-targets."direnv/direnvrc" =
    config.lib.dotfiles-with-targets.fromSimpleXDG config.xdg.configFile."direnv/direnvrc";
}
