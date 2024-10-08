{ homeDirectory
, pkgs
, system
, username
}:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  home = {
    inherit homeDirectory packages username;

    sessionPath = [ "$HOME/.local/bin" ];

    stateVersion = "24.05";     # See https://nixos.org/manual/nixpkgs/stable for most recent
    shellAliases = {
      hm = "~/.config/home-manager/bin/hm";
    };
  };

  programs = import ./programs.nix{inherit pkgs;};

  xdg.enable = true;
}
