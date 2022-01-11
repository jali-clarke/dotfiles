{ config, lib, ... }:
{
  config.programs.zsh = {
    enable = lib.mkDefault config.dotfiles.enableAll;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    initExtra = ''
      bindkey "ç" fzf-cd-widget
    '';
  };

  config.dotfiles.config = {
    ".zshenv" = assert config.programs.zsh.enable; config.lib.dotfiles.fromSimpleXDG config.home.file.".zshenv";
    ".zshrc" = assert config.programs.zsh.enable; config.lib.dotfiles.fromSimpleXDG config.home.file.".zshrc";
  };
}
