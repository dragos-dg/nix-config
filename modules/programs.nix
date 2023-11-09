{
  home-manager = {
    enable = true;
  };
  zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };
  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

