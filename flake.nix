{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = { username, system ? "x86_64-linux", homePrefix ? "/home" }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home/default.nix
            {
              home.username = username;
              home.homeDirectory = "${homePrefix}/${username}";
            }
          ];
        };
    in {
      homeConfigurations = {
        "frener"       = mkHome { username = "frener"; };
        "provac"       = mkHome { username = "provac"; };
        "frener-darwin" = mkHome { username = "frener"; system = "aarch64-darwin"; homePrefix = "/Users"; };
      };
    };
}
