{ pkgs, pkgsUnstable, ... }:
{
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.tmux.enable
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    shortcut = "a";
    terminal = "screen-256color";
    keyMode = "vi";

    # @TODO: tmuxinator or tmuxp
    plugins = [
      #{
      #  plugin = pkgs.tmuxPlugins.gruvbox;
      #  extraConfig = ''
      #    set -g @tmux-gruvbox 'dark'
      #  '';
      #}
      #{
      #  plugin = pkgs.tmuxPlugins.catppuccin;
      #  extraConfig = ''
      #    #set -g @catppuccin_flavour 'latte'
      #    #set -g @catppuccin_flavour 'frappe'
      #    set -g @catppuccin_flavour 'macchiato'
      #    #set -g @catppuccin_flavour 'mocha'
      #    set -g @catppuccin_window_default_text "#W"
      #    set -g @catppuccin_window_current_text "#W"
      #  '';
      #}
      {
        plugin = pkgs.tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
          set -g @dracula-show-fahrenheit false
          set -g @dracula-show-weather false
          set -g @dracula-show-location false
          set -g @dracula-show-timezone false
          set -g @dracula-plugins "ssh-session attached-clients synchronize-panes"
        '';
      }
    ];

    extraConfig = ''
      bind r \
        source-file ~/.config/tmux/tmux.conf \;\
        display 'Config reloaded'

      # Retain cwd on newer tmux
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind M-i split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind M-e split-window -c "#{pane_current_path}"

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # move panes between windows
      # http://unix.stackexchange.com/questions/103041/can-i-make-a-tmux-pane-sticky
      bind-key M-[ move-pane -t ':-'
      bind-key M-] move-pane -t ':+'

      # Synchronize panes
      bind S setw synchronize-panes

      # Toggle mouse on with ^B m
      bind m \
        set -g mouse on \;\
        set -g mouse-resize-pane on \;\
        set -g mouse-select-pane on \;\
        set -g mouse-select-window on \;\
        display 'Mouse: ON'

      # Toggle mouse off with ^B M
      bind M \
        set -g mouse off \;\
        set -g mouse-resize-pane off \;\
        set -g mouse-select-pane off \;\
        set -g mouse-select-window off \;\
        display 'Mouse: OFF'
    '';

#      ## ######################################################################## ###
#      ## Theme from http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
#      ##
#      # panes
#      set -g pane-border-style fg=black
#      set -g pane-active-border-style fg=brightred
#
#      ## Status bar design
#      # status line
#      #set -g status-utf8 on
#      set -g status-justify left
#      set -g status-style bg=default,fg=colour12
#      set -g status-interval 2
#
#      # messaging
#      set -g message-style fg=black,bg=yellow
#      set -g message-command-style fg=blue,bg=black
#
#      # window mode
#      setw -g mode-style bg=colour6,fg=colour0
#
#      # window status
#      setw -g window-status-format " #F#I:#W#F "
#      setw -g window-status-current-format " #F#I:#W#F "
#      setw -g window-status-format "#[fg=magenta]#[bg=black] #I #[bg=cyan]#[fg=colour8] #W "
#      setw -g window-status-current-format "#[bg=brightmagenta]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
#      setw -g window-status-current-style bg=colour0,fg=colour11,dim
#      setw -g window-status-style bg=green,fg=black,reverse
#
#      # Info on left (I don't have a session display for now)
#      set -g status-left ""
#
#      # loud or quiet?
#      set-option -g visual-activity off
#      set-option -g visual-bell off
#      set-option -g visual-silence off
#      set-window-option -g monitor-activity off
#      set-option -g bell-action none
#
#      # The modes
#      setw -g clock-mode-colour colour135
#      setw -g mode-style fg=colour196,bg=colour238,bold
#
#      # The panes
#      set -g pane-border-style bg=colour235,fg=colour238
#      set -g pane-active-border-style bg=colour236,fg=colour51
#
#      # The statusbar
#      set -g status-position bottom
#      set -g status-style bg=colour234,fg=colour137,dim
#      set -g status-left ""
#      set -g status-right '#[fg=colour233,bg=colour241,bold] %Y-%m-%d #[fg=colour233,bg=colour245,bold] %H:%M:%S '
#      set -g status-right-length 50
#      set -g status-left-length 20
#
#      setw -g window-status-current-style fg=colour81,bg=colour238,bold
#      setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
#      setw -g window-status-style fg=colour138,bg=colour235,none
#      setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
#      setw -g window-status-bell-style fg=colour255,bg=colour1,bold
#
#      # The messages
#      set -g message-style fg=colour232,bg=colour166,bold
#    '';



#      # settings
#      set-option -g allow-rename off
#      set-option -g display-time 3000
#      set-window-option -g xterm-keys on
#      setw -g monitor-activity on
#
#      # Shift-Alt arrow to switch windows
#      bind -n S-M-Left  previous-window
#      bind -n S-M-Right next-window
#      bind -n M-N     previous-window
#      bind -n M-I     next-window
#
#      # Shift-Ctrl arrow to move pane between windows
#      #bind -n S-C-Left  move-pane -t ':-'
#      #bind -n S-C-Right move-pane -t ':+'
#
#      # Theme
#      # default, black, red, green, yellow, blue, magenta, cyan, white
#      # 256-color palette: colour0..colour255
#      #set -g status-bg green
#      #set -g status-fg black
#      #set -g status-attr none
#      #set -g window-status-current-bg black
#      #set -g window-status-current-fg green
#      #set -g window-status-current-attr bold
#      #set -g window-status-activity-bg brightgreen
#      #set -g window-status-activity-fg black
#      #set -g window-status-activity-attr bold
#      #set -g status-left-length 30
#      #set -g status-left '#[fg=brightgreen](#S) #(whoami)'
#      #set -g status-right '#[fg=brightgreen]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=black]%Y-%m-%d %H:%M#[default]'

  };
}
