{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    initExtra = ''
      bindkey "ç" fzf-cd-widget
    '';
  };
}