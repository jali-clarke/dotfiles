{ pkgs, config, lib, ... }: {
  programs.fzf = rec {
    enable = lib.mkDefault config.dotfiles.enableAll;
    enableZshIntegration = true;

    defaultCommand = "${pkgs.fd}/bin/fd --type f";

    fileWidgetCommand = defaultCommand;
    fileWidgetOptions = [
      "--preview '${pkgs.bat}/bin/bat --color=always --paging=never --style=changes {}' --preview-window down"
    ];

    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    changeDirWidgetOptions =
      [ "--preview '${pkgs.tree}/bin/tree -C {} | head -200'" ];
  };
}
