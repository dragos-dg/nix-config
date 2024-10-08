{ pkgs }:

let
  packages = with pkgs; [
    iterm2
    neovim
    laio
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
