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

  config.dotfiles.config = lib.mkIf config.programs.zsh.enable {
    ".zshenv" = config.lib.dotfiles.fromSimpleXDG config.home.file.".zshenv";
    ".zshrc" = config.lib.dotfiles.fromSimpleXDG config.home.file.".zshrc";
  };
}
