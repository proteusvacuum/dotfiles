{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
    ./tmux.nix
    ./packages.nix
    ./emacs.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # Copy ghostty terminfo so Nix-built tools (tmux, etc.) can find it.
  # Nix links against its own ncurses which doesn't search /usr/share/terminfo.
  home.file.".terminfo/x/xterm-ghostty".source = "${pkgs.ghostty}/share/terminfo/x/xterm-ghostty";
  home.file.".terminfo/g/ghostty".source = "${pkgs.ghostty}/share/terminfo/g/ghostty";
}
