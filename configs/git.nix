{ config, lib, ... }:
{
  config.programs.git = {
    enable = lib.mkDefault config.dotfiles.enableAll;
    lfs.enable = true;
    delta.enable = true;

    extraConfig = {
      pull = {
        ff = "only";
        rebase = false;
      };

      push = {
        autoSetupRemote = true;
        default = "upstream";
      };

      rebase = {
        autostash = true;
      };
    };

    aliases = {
      autosquash = "!GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash";
      branchc = "branch --show-current";
      brancho = "!echo origin/$(git branchc)";
      diffo = "!git diff $(git brancho)";
      fixup = "commit --fixup";
      fixupa = "commit -a --fixup";
      pushf = "push --force-with-lease";
      reseto = "!git reset $(git brancho)";
      rp = "rev-parse";
      rps = "rev-parse --short";
      root = "rev-parse --show-toplevel";
    };
  };

  config.dotfiles.config = lib.mkIf config.programs.git.enable {
    "git/config" = config.lib.dotfiles.fromSimpleXDG config.xdg.configFile."git/config";
  };
}
