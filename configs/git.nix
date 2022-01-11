{ config, lib, ... }:
{
  config.programs.git = {
    enable = lib.mkDefault config.dotfiles.enableAll;
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

  config.dotfiles.config."git/config" =
    assert config.programs.git.enable; config.lib.dotfiles.fromSimpleXDG config.xdg.configFile."git/config";
}
