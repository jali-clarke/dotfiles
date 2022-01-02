{
  imports = [
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./vscode.nix
    ./zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
