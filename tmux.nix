{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    sensibleOnTop = true;
    escapeTime = 50;
    focusEvents = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = dotbar;
        extraConfig = ''
          set -g @tmux-dotbar-right true
          set -g @tmux-dotbar-bg "#1e1e2e"
          set -g @tmux-dotbar-fg "#585b70"
          set -g @tmux-dotbar-fg-current "#cdd6f4"
          set -g @tmux-dotbar-fg-session "#9399b2"
          set -g @tmux-dotbar-fg-prefix "#cba6f7"
        '';
      }
    ];
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm*:Tc"
      set-option -g allow-passthrough on
    '';
  };
}
