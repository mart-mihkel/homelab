{
  programs.tmux = {
    enable = true;
    mouse = true;

    keyMode = "vi";
    baseIndex = 1;

    extraConfig = ''
      set -gq allow-passthrough on
      set -g visual-activity off

      set -g set-titles-string "#{pane_current_command}"
      set -g set-titles on

      set-window-option -g window-active-style "bg=terminal"
      set-window-option -g window-style "bg=terminal"

      set -g pane-active-border-style "fg=default"
      set -g pane-border-style "fg=default"

      set -g status-style "fg=default bg=default"
      set -g status-right "#(whoami)@#H"

      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
