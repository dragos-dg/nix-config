{ pkgs }:

let
  packages = with pkgs; [
    iterm2
    neovim
    lsd
    cargo
    nerdfonts
    utm
    delta
    hack-font
    inetutils
    android-tools
    htop
  ];
in packages
