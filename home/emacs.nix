{ pkgs, ... }:

{
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # Ensures the Nix emacsclient is on PATH ahead of any system install (e.g. snap)
  home.packages = [ pkgs.emacs ];
}
