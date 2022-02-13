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
      diffo = "!git diff $(git brancho)";
      fixup = "commit --fixup";
      fixupa = "commit -a --fixup";
      pushf = "push --force-with-lease";
      pushuo = "!git push -u origin $(git branchc)";
      rp = "rev-parse";
      rps = "rev-parse --short";
    };
  };

  config.dotfiles.config = lib.mkIf config.programs.git.enable {
    "git/config" = config.lib.dotfiles.fromSimpleXDG config.xdg.configFile."git/config";
  };
}
