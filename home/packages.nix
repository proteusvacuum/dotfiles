{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # shell tools
    fzf
    ripgrep
    jq
    silver-searcher  # ag
    ack

    # rust
    # rustup manages its own toolchain versions (stable/nightly/etc.)
    # this is more flexible than pinning rustc directly via nixpkgs
    rustup

    # nix
    nixd        # nix language server
    nixfmt-rfc-style  # formatter

    # python
    uv  # replaces pip/virtualenv/pyenv

  ];
}
