{ config, ... }:
{
  config.programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    initExtra = ''
      bindkey "ç" fzf-cd-widget
    '';
  };

  config.dotfiles-with-targets = {
    ".zshenv" = config.lib.dotfiles-with-targets.fromSimpleXDG config.home.file.".zshenv";
    ".zshrc" = config.lib.dotfiles-with-targets.fromSimpleXDG config.home.file.".zshrc";
  };
}
