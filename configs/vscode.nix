{ pkgs, config, lib, ... }: {
  nixpkgs.config.allowUnfree = if config.programs.vscode.enable then lib.mkForce true else lib.mkDefault false;

  programs.vscode = {
    enable = lib.mkDefault config.dotfiles.enableAll;
    extensions =
      let exts = pkgs.vscode-extensions;
      in
      [
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
}
