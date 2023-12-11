{pkgs,...}:
let
  tmux-catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    name = "catppuccin";
    pluginName = "catppuccin";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "47e33044b4b47b1c1faca1e42508fc92be12131a";
      sha256 = "kn3kf7eiiwXj57tgA7fs5N2+B2r441OtBlM8IBBLl4I=";
    };
  };
in
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
  tmux = {
     enable = true;
     shortcut = "a";
     baseIndex = 1;
     keyMode = "vi";

     extraConfig = ''
      # begin additional user settings
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g mouse on
      set -g status-position top
      set -g default-terminal "tmux-256color"

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      bind -n C-M-k send-keys C-l \; send-keys -R \; clear-history

      # end additional user settings
    '';
    plugins = with pkgs.tmuxPlugins; [
      pain-control
      sensible
      yank

      {
        plugin = tmux-catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_left_separator ""
            set -g @catppuccin_window_right_separator " "
            set -g @catppuccin_window_middle_separator " █"
            set -g @catppuccin_window_number_position "right"

            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_default_text "#W"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "#W"

            set -g @catppuccin_status_modules_left "session"
            set -g @catppuccin_status_modules_right "directory host"
            set -g @catppuccin_status_left_separator  " "
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_status_right_separator_inverse "no"
            set -g @catppuccin_status_fill "icon"
            set -g @catppuccin_status_connect_separator "no"

            set -g @catppuccin_directory_text "#(echo #{pane_current_path} | sed \"s|^$HOME|~|\" | awk -F/ -v OFS=/ -v len=20 '{ if (length(\$0) > len && NF > 4) print \$1,\$2 \"...\", \$(NF-1), \$NF; else print \$0; }')"
          '';
      }
    ];
  };
}
