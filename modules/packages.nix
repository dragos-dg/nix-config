{ pkgs }:

let
  packages = with pkgs; [
    iterm2
    neovim
    lsd
    cargo
    nerdfonts
    hack-font
  ];
in packages
