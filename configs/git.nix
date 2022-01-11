{ config, ... }:
{
  config.programs.git = {
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

  config.dotfiles-with-targets."git/config" =
    config.lib.dotfiles-with-targets.fromSimpleXDG config.xdg.configFile."git/config";
}
