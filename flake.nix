{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    laio.url = "github:ck3mp3r/laio-cli";
  };

  outputs = { self, nixpkgs, home-manager, laio }:
    let
      # Values you should modify
      username = "dragos"; # $USER
      system = "aarch64-darwin";  # x86_64-linux, aarch64-multiplatform, etc.

      pkgs = import nixpkgs {
        inherit system;
        
        overlays = [
          (final: next: {
            laio = laio.packages.${system}.default;
          })
        ];

        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
          experimental-features = "nix-command flakes";
        };
      };

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      homeDirectory = "/${homeDirPrefix}/${username}";

      home = (import ./modules/home.nix {
        inherit homeDirectory pkgs system username;
      });
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          home
          ./modules/zsh.nix
          ./modules/starship.nix
        ];
      };
    };
}
