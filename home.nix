{
  inputs,
  system,
  user,
  pkgs,
  ...
}:

{
  home.username = "${user.name}";
  home.homeDirectory = "/home/${user.name}";
  home.shell.enableShellIntegration = true;
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    mosh
    nixfmt
    jq
    awscli2
    inputs.nix-auth.packages.${system}.default
  ];

  home.sessionVariables = {
    WORK = "/work/${user.name}";
    COLORTERM = "truecolor";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  imports = [
    ./tmux.nix
    ./email.nix
    ./git.nix
    ./helix.nix
    ./nixvim.nix
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      autosuggestion.enable = true;
    };
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    bat.enable = true;
    bottom.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fd.enable = true;
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [
        "--preview 'bat --number --color=always {}'"
      ];
      changeDirWidgetCommand = "fd --type d";
    };
    ripgrep.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    lazygit.enable = true;
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
