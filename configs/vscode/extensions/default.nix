{ pkgs, vscode-extensions }:
[
  vscode-extensions._4ops.terraform
  vscode-extensions.bbenoist.nix
  vscode-extensions.brettm12345.nixfmt-vscode
  vscode-extensions.dhall.dhall-lang
  vscode-extensions.eamodio.gitlens
  vscode-extensions.justusadam.language-haskell

  (pkgs.callPackage ./packer.nix { })
]
