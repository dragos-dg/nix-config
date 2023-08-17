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

    shellAliases = {
      hm = "~/.config/home-manager/bin/hm";
    };
  };

  programs = import ./programs.nix;
}
