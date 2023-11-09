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
  git = {
    enable = true;
    extraConfig = {
      core = {
        whitespace = "trailing-space,space-before-tab";
        editor = "nvim";
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta delta --color-only";
      };
      delta = {
        navigate = true;
        light = false;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Nord";
        true-color = "always";
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };
}
