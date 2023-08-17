{ homeDirectory
, pkgs
, stateVersion
, system
, username
}:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  home = {
    inherit homeDirectory packages stateVersion username;

    sessionPath = [ "$HOME/.local/bin" ];

    shellAliases = {
      hm = "~/.config/home-manager/bin/hm";
    };
  };

  programs = import ./programs.nix;

  xdg.enable = true;
}
