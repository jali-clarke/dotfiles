{ pkgs, vscode-extensions }:
[
  vscode-extensions."4ops".terraform
  vscode-extensions.bbenoist.nix
  vscode-extensions.bierner.markdown-mermaid
  vscode-extensions.brettm12345.nixfmt-vscode
  vscode-extensions.dhall.dhall-lang
  vscode-extensions.eamodio.gitlens
  vscode-extensions.elmtooling.elm-ls-vscode
  vscode-extensions.justusadam.language-haskell

  (pkgs.callPackage ./cuelang.nix { })
  (pkgs.callPackage ./packer.nix { })
  (pkgs.callPackage ./test-adapter-converter.nix { })
  (pkgs.callPackage ./vscode-pets.nix { })
  (pkgs.callPackage ./vscode-test-explorer.nix { })
]
