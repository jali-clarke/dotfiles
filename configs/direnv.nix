{ config, lib, ... }:
{
  config.programs.direnv = {
    enable = lib.mkDefault config.dotfiles.enableAll;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  config.dotfiles.config."direnv/direnvrc" =
    assert config.programs.direnv.enable; config.lib.dotfiles.fromSimpleXDG config.xdg.configFile."direnv/direnvrc";
}
