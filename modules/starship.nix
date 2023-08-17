{
  programs.starship =
    {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings =
        {
          command_timeout = 1500;
          aws = {
            symbol = "  ";
            disabled = true;
          };
          azure = {
            disabled = true;
          };
          gcloud = {
            symbol = "  ";
            disabled = true;
          };
          buf = {
            symbol = " ";
          };
          c = {
            symbol = " ";
          };
          conda = {
            symbol = " ";
          };
          dart = {
            symbol = " ";
          };
          directory = {
            read_only = " ";
          };
          docker_context = {
            symbol = " ";
            disabled = true;
          };
          elixir = {
            symbol = " ";
          };
          elm = {
            symbol = " ";
          };
          git_branch = {
            symbol = " ";
          };
          golang = {
            symbol = " ";
          };
          haskell = {
            symbol = " ";
          };
          hg_branch = {
            symbol = " ";
          };
          java = {
            symbol = " ";
          };
          julia = {
            symbol = " ";
          };
          lua = {
            symbol = " ";
          };
          memory_usage = {
            symbol = " ";
          };
          meson = {
            symbol = "喝 ";
          };
          nim = {
            symbol = " ";
          };
          nix_shell = {
            symbol = " ";
          };
          nodejs = {
            symbol = " ";
          };
          package = {
            symbol = " ";
          };
          python = {
            symbol = " ";
          };
          rlang = {
            symbol = "ﳒ ";
          };
          ruby = {
            symbol = " ";
          };
          rust = {
            symbol = " ";
          };
          scala = {
            symbol = " ";
          };
          openstack = {
            disabled = true;
          };
          spack = {
            symbol = "🅢 ";
            character = {
              success_symbol = "[❯](blue)";
              error_symbol = "[❯](red)";
              vimcmd_symbol = "[❮](green)";
            };
          };
        };
    };
}
