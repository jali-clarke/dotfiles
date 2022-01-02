{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;

    extraConfig = { pull.rebase = false; };

    aliases = {
      autosquash = "!GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash";
      branchc = "branch --show-current";
      brancho = "!echo origin/$(git branchc)";
      diffc = "!git diff $1~1"; # automatically appends $1
      diffo = "!git diff $(git brancho)";
      fixup = "commit --fixup";
      fixupa = "commit -a --fixup";
      pushf = "push --force-with-lease";
      pushuo = "!git push -u origin $(git branchc)";
    };
  };

  programs.fzf = rec {
    enable = true;
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

  programs.vscode = {
    enable = true;
    extensions = let exts = pkgs.vscode-extensions;
    in [
      exts._4ops.terraform
      exts.bbenoist.nix
      exts.brettm12345.nixfmt-vscode
      exts.dhall.dhall-lang
      exts.eamodio.gitlens
      exts.justusadam.language-haskell
    ];

    userSettings = {
      "files.autoSave" = "afterDelay";
      "window.zoomLevel" = 1;
      "workbench.editor.enablePreview" = false;
      "update.mode" = "none";
      "[nix]"."editor.tabSize" = 2;
      "[haskell]"."editor.tabSize" = 2;
    };
  };

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
