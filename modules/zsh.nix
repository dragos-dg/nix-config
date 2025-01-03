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
        kl="kubectl";
        fl_export="export KUBECONFIG=~/.config/proxyman/kube.conf";
        colima_start="colima start --kubernetes --kubernetes-version \"v1.25.11+k3s1\" --cpu 10 --memory 24";
        gcloud_login="gcloud auth login";
        wvm="gcloud compute start-iap-tunnel cards-mas-windows-vm 3389 --local-host-port=localhost:3398 --zone=europe-west2-a --project=cards-mas-vm";
        t3="proxyman start -p -k b2b_staging -f https://functional.card.env.germany.jpmorgan.io/t3/";
        gu="for n in `find . -name .git`; do pushd `dirname $n`; gfa; ggpull --autostash; popd; done;";
        pulumi="proxyman start -p -k b2b_staging";
        stg="proxyman start -p -k b2b_staging_stg";
        dev="proxyman start -p -k b2b_staging_dev";
        jfrog="echo $JF_ACCESS_TOKEN | docker login https://chaseio.jfrog.io -u $JF_USERNAME --password-stdin";
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
 
      JF_USERNAME=dragos.dumitrescu@chase.io
      JF_ACCESS_TOKEN=$(jf access-token-create --expiry 86400  --reference=true | jq -r ".reference_token")
      export JF_USERNAME
      export JF_ACCESS_TOKEN
      echo $JF_ACCESS_TOKEN | docker login https://chaseio.jfrog.io -u $JF_USERNAME --password-stdin

      source ~/.config/zsh/localpat
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" ];
      };
    };
}
