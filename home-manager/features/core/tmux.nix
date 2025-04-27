{config, lib, pkgs, ...}:
let
  thm = config.theme.colors;

  tmux-current-pane-hostname = pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-current-pane-hostname";
      version = "27-04-2025";
      rtpFilePath = "current_pane_hostname.tmux";
      src = pkgs.fetchFromGitHub {
        owner = "tony-sol";
        repo = "tmux-current-pane-hostname";
        rev = "2ea196be6d6259a02d553a13bdcd243b4d0e8660";
        sha256 = "sha256-FRzEDp5RS2BMy0EHGPpy/C81GSWVzmyqpEcIogJf8NM=";
      };
    };
  tmux-floating-terminal = pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-floating-terminal";
      version = "27-04-2025";
      rtpFilePath = "floating_plugin.tmux";
      src = pkgs.fetchFromGitHub {
        owner = "lloydbond";
        repo = "tmux-floating-terminal";
        rev = "054659912b395bc0ea854ce8eb388ab7d577fc84";
        sha256 = "sha256-h/ZMNzRBXpjG/aKDDGB8XnuL6vELHVWv4wd4mHz/NVo=";
      };
    };
in
{
  programs.tmux = {
    enable = true;
    baseIndex =  1;
    clock24 = true;
    terminal = "tmux-256color";
    historyLimit = 5000;
    prefix = "C-Space";
    keyMode = "vi";
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.catppuccin; 
        # Hacking this to work like base16 theme :)
        extraConfig = ''

          # Define color variables
          set -g @catppuccin_bg "${thm.base00}"
          set -g @catppuccin_fg "${thm.base05}"

          set -g @catppuccin_rosewater "${thm.base06}"
          set -g @catppuccin_flamingo "${thm.base0F}"
          set -g @catppuccin_pink "${thm.base06}"
          set -g @catppuccin_mauve "${thm.base0E}"
          set -g @catppuccin_red "${thm.base08}"
          set -g @catppuccin_maroon "${thm.base0F}"
          set -g @catppuccin_peach "${thm.base09}"
          set -g @catppuccin_yellow "${thm.base0A}"
          set -g @catppuccin_green "${thm.base0B}"
          set -g @catppuccin_teal "${thm.base0C}"
          set -g @catppuccin_sky "${thm.base0D}"
          set -g @catppuccin_sapphire "${thm.base0D}"
          set -g @catppuccin_blue "${thm.base0D}"
          set -g @catppuccin_lavender "${thm.base07}"

          # Surfaces and overlays
          set -g @catppuccin_overlay_2 "${thm.base04}"
          set -g @catppuccin_overlay_0 "${thm.base03}"
          set -g @catppuccin_surface_1 "${thm.base03}"
          set -g @catppuccin_surface_0 "${thm.base02}"
          set -g @catppuccin_mantle "${thm.base01}"
          set -g @catppuccin_crust "${thm.base00}"
          
          # General statusline customisation
          set -g status-left-length 100
          set -g status-left ""
          set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_mantle},bold]  #S },#{#[bg=#{@thm_mantle},fg=#{@thm_green}]  #S }}"
          set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_maroon}]  #{pane_current_command} "
          set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "

          # Configure Online
          set -g @online_icon "ok"
          set -g @offline_icon "nok"

          # status right style
          set -g status-right-length 100
          set -g status-right ""
          set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_mauve}]  #U@#H "
          set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0}, none]│"
          set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

          # window style
          set -wg automatic-rename on
          set -g automatic-rename-format ""
          set -g window-status-separator '|'
          set -g status-justify 'absolute-centre'
          set -g @catppuccin_window_status_style 'custom'
          set -g @catppuccin_window_flags "icon"
          set -g @catppuccin_window_number ""
          set -g @catppuccin_window_text "#[fg=#{@thm_rosewater},bg=#{@thm_mantle}] #I#{?#{!=:#{window_name},},: #W,}"
          set -g @catppuccin_window_current_number ""
          set -g @catppuccin_window_current_text "#[fg=#{@thm_mantle},bg=#{@thm_peach}] #I#{?#{!=:#{window_name},},: #W,}"
        '';
      }
      tmux-current-pane-hostname
      {
        plugin = tmux-floating-terminal;
        extraConfig = ''
          unbind-key -T prefix i
          set -g @floating_scratch_term 'i'
          set -g @floating_scratch_to_active_win 'M-h'
          set -g @floating_scratch_to_win 'M-l'
          set -g @floating_active_pane_to_scratch 'M-m'
        '';
      }
    ];
    extraConfig = ''
      set -g mouse on
      set -g status-interval 1
      set -g escape-time 10
      set -g focus-events on
      set -g status on

      bind \` switch-client -t'{marked}'
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on

      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on

      # Use Alt-arrow keys to switch panes
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      # Shift arrow to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Set easier window split keys
      bind-key v split-window -h -c '#{pane_current_path}'
      bind-key n split-window -v -c '#{pane_current_path}'

      # Swap windows
      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1

      # Previous windows
      bind Space last-window

      # Resize panes
      bind -r C-j resize-pane -D 15
      bind -r C-k resize-pane -U 15
      bind -r C-h resize-pane -L 15
      bind -r C-l resize-pane -R 15

      # First and Last tabs
      bind 0 select-window -t ":^"
      bind 9 select-window -t ":$"

      bind -n "M-0" select-window -t ":^"
      bind -n "M-1" select-window -t ":1"
      bind -n "M-2" select-window -t ":2"
      bind -n "M-3" select-window -t ":3"
      bind -n "M-4" select-window -t ":4"
      bind -n "M-5" select-window -t ":5"
      bind -n "M-6" select-window -t ":6"
      bind -n "M-7" select-window -t ":7"
      bind -n "M-8" select-window -t ":8"
      # Browsers also select last tab with M-9.
      bind -n "M-9" select-window -t ":$"
      # Match iTerm2.
      bind -n "M-{" previous-window
      bind -n "M-}" next-window
    '';
  };
}