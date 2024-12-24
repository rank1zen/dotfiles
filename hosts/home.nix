{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionVariables = {
      EDITOR = "nvim";
    };
    activation = {
      linkMyStuff = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ln -sf -t $HOME/.config $HOME/nix-cfg/nvim  $HOME/nix-cfg/qutebrowser $HOME/nix-cfg/hypr
      '';
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fd
    fzf
    jq
    ripgrep
    unzip
    zip

    # hyprland things
    slurp
    grim
    fuzzel
    wl-clipboard
    swww
    wlsunset

    qutebrowser
    hyprland
  ];

  programs.password-store = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "gordon";
    userEmail = "gordonchen2014@gmail.com";
  };

  programs.bash.enable = true;

  programs.foot = {
    enable = true;
    settings = {
      main.font = "Go Mono:size=12";
      main.dpi-aware = true;
      main.pad = "10x10";
      colors.background = "ffffff";
      colors.foreground = "000000";
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      font = "LexendDeca";
      default-fg = "#000000";
      default-bg = "#ffffff";

      completion-bg = "#ffffff";
      completion-fg = "#999999";
      completion-highlight-bg = "#ffffff";
      completion-highlight-fg = "#000000";
      completion-group-bg = "#ffffff";
      completion-group-fg = "#000000";
      notification-bg = "#ffffff";
      notification-fg = "#000000";
      notification-error-bg = "#ffffff";
      notification-error-fg = "#ff0000";
      notification-warning-bg = "#ffffff";
      notification-warning-fg = "#ff0000";
      inputbar-fg = "#000000";
      inputbar-bg = "#ffffff";

      index-fg = "#999999";
      index-bg = "#ffffff";
      index-active-fg = "#000000";
      index-active-bg = "#ffffff";

      render-loading-bg = "#ffffff";
      render-loading-fg = "#000000";

      highlight-color = "rgba(0,0,0,0.2)";
      highlight-fg = "rgba(0,0,0,0.2)";
      highlight-active-color = "rgba(0,0,0,0.2)";

      window-title-home-tilde = "true";
      window-title-page = "true";
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      ripgrep
      lua-language-server
      stylua
      nixd
      alejandra
    ];
  };

  xdg = {
    enable = true;

    userDirs.enable = true;
    userDirs.createDirectories = true;
  };

#  wayland.windowManager.hyprland = {
#    enable = true;
#  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    nix-direnv.enable = true;
  };

  home.stateVersion = "24.05";
}
