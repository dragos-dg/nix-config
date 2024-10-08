{ config, pkgs, ... }:

{
  programs.zsh =
    {
      enable = true;

      autosuggestion.enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      syntaxHighlighting.enable = true;
      autocd = true;

      sessionVariables = {
        EDITOR = "lvim";
        CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include";
        DOCKER_HOST="unix://$HOME/.colima/docker.sock";
        TESTCONTAINERS_RYUK_DISABLED=true;
        TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="~/.colima/docker.sock";

        #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
        SDKMAN_DIR="$HOME/.sdkman";

      };
      localVariables = {
      };
      shellAliases = {
        hm = "~/.config/home-manager/bin/hm";
        myip = "curl https://ipecho.net/plain; echo";
        gitup = "for n in `find . -name .git`; do pushd `dirname $n`; gfa; ggpull --autostash; popd; done;";
        nix-shell-unstable = "nix-shell -I nixpkgs=channel:nixpkgs-unstable";

        ls = "lsd";
        lg = "lazygit";
        ll = "ls -la";
        k = "kubectl";
        kx = "kubectx";

        tree = "lsd --tree";
        gradle = "./gradlew";
        projects = "cd ~/projects";
        charts = "cd ~/projects/card-tooling/charts";
        kl="kubectl";
        fl_export="export KUBECONFIG=~/.config/proxyman/kube.conf";
        colima_start="colima start --kubernetes --kubernetes-version \"v1.25.11+k3s1\" --cpu 10 --memory 24";
        gcloud_login="gcloud auth login";
        vts_tunel="gcloud compute start-iap-tunnel cards-mas-windows-vm 3389 --local-host-port=localhost:3398 --zone=europe-west2-a --project=cards-mas-vm";
        t3_start="proxyman start -p -k b2b_staging -f https://functional.card.env.germany.jpmorgan.io/t3/";
        gu="for n in `find . -name .git`; do pushd `dirname $n`; gfa; ggpull --autostash; popd; done;";
        deployments="FLORENCE_PROJECT_ID=01H5W9K2315FH6PTC708SR5509 provision environments";
        proxy_port="proxyman print staging germany | cut -d \":\" -f 2 | pbcopy";
 };

      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        expireDuplicatesFirst = true;
        ignoreDups = true;
      };

      historySubstringSearch = {
        enable = true;
      };

      initExtra = ''
      # SDK Man
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix

      #   source ~/.config/op/plugins.sh
      #   bindkey '^[[Z' autosuggest-accept # shift + tab | autosuggest

      source ~/.config/zsh/localpat
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" ];
      };
    };
}
