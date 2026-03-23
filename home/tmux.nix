{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-t";
    mouse = true;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-power";
          rtpFilePath = "tmux-power.tmux";
          version = "unstable";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "tmux-power";
            rev = "HEAD";
            sha256 = "sha256-HiT2AMbeaB9A5elXA1rNJYyvLOmsvSC0F1Pn1Z6VDxI=";
          };
        };
        extraConfig = "set -g @tmux_power_theme 'gold'";
      }
    ];
    extraConfig = ''
      setw -g automatic-rename on
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
    '';
  };
}
