{
  imports = [
    ./direnv.nix
    ./dotfiles-with-targets.nix
    ./fzf.nix
    ./git.nix
    ./vscode.nix
    ./zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
