{ pkgs }:

let
  packages = with pkgs; [
    iterm2
    neovim
    lsd
    thefuck
  ];
in packages
