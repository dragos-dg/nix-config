{ config, pkgs, ... }:

{
  programs.zsh =
    {
      enable = true;

      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/zsh";
      autocd = true;

      sessionVariables = {
        EDITOR = "lvim";
        CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include";
        DOCKER_HOST="unix://$HOME/.colima/docker.sock";
        TESTCONTAINERS_RYUK_DISABLED=true;
        FLORENCE_PLATFORM="germany-staging";
        FLORENCE_PROJECT_ID="01H5W9K2315FH6PTC708SR5509";
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
        fl_export="export KUBECONFIG=~/.config/florence-cli/kubeconfig";
        fl_login="florence gcp login";
        fl_k_proxy="florence magic kube-proxy";
        fl_http_proxy="florence magic http-proxy";
        colima_start="colima start --kubernetes --kubernetes-version \"v1.24.14+k3s1\" --cpu 6 --memory 24";
        gcloud_login="gcloud auth login";
        vts_tunel="gcloud compute start-iap-tunnel cards-mas-windows-vm 3389 --local-host-port=localhost:3398 --zone=europe-west2-a --project=cards-mas-vm";
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
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix

      #   source ~/.config/op/plugins.sh
      #   bindkey '^[[Z' autosuggest-accept # shift + tab | autosuggest
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" "fzf" ];
      };
    };
}
