{ pkgs }:

let
  packages = with pkgs; [
    iterm2
    neovim
    lsd
    cargo
    nerdfonts
    utm
    hack-font
  ];
in packages
