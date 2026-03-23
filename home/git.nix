{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Farid Rener";
      user.email = "proteusvacuum@gmail.com";
      alias = {
        co = "checkout";
        promote = "!$ZSH/bin/git-promote";
        count = "!git shortlog -sn";
      };
      hub.protocol = "https";
      credential.helper = "cache";
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };
      core = {
        excludesfile = "~/.gitignore";
        editor = "ec";
      };
      apply.whitespace = "nowarn";
      mergetool.keepBackup = false;
      difftool.prompt = false;
      help.autocorrect = 1;
      push.default = "simple";
    };
  };
}
