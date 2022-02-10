{ pkgs, config, lib, ... }: {
  config.nixpkgs.config.allowUnfree = if config.programs.vscode.enable then lib.mkForce true else lib.mkDefault false;

  config.programs.vscode = {
    enable = lib.mkDefault config.dotfiles.enableAll;
    extensions = pkgs.callPackage ./extensions {};

    userSettings = {
      "files.autoSave" = "afterDelay";
      "window.zoomLevel" = 1;
      "workbench.editor.enablePreview" = false;
      "update.mode" = "none";
      "[nix]"."editor.tabSize" = 2;
      "[haskell]"."editor.tabSize" = 2;
    };
  };

  config.dotfiles.config =
    let
      userDir = if pkgs.stdenv.hostPlatform.isDarwin then "Library/Application Support" else config.xdg.configHome;
      relativeTarget = "${userDir}/Code/User/settings.json";
    in
    lib.mkIf config.programs.vscode.enable {
      "vscode/settings" = rec {
        contents = builtins.readFile "${file}";
        file = config.home.file."${relativeTarget}".source;
        target = if pkgs.stdenv.hostPlatform.isDarwin then "${config.home.homeDirectory}/${relativeTarget}" else relativeTarget;
      };
    };
}
