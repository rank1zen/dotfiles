{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./qutebrowser.nix
    ./foot.nix
    ./zathura.nix
  ];
  home = {
    username = "gordo";
    homeDirectory = "/home/gordo";
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "fish";
    };
    activation = {
      linkMyStuff = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ln -sf -t $HOME/.config $HOME/nix-cfg/nvim $HOME/nix-cfg/hypr
      '';
    };
    packages = with pkgs; [
      tree
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

      hyprland
    ];

    # DO NOT TOUCH
    stateVersion = "24.05";
  };

  xdg = {
    enable = true;

    userDirs.enable = true;
    userDirs.createDirectories = true;
  };

  programs.home-manager.enable = true;

  programs.password-store = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "gordon";
    userEmail = "gordonchen2014@gmail.com";
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      ripgrep
      lua-language-server
      stylua
      nixd
      alejandra
    ];
  };

  programs.fish = {
    enable = true;
  };

  #  wayland.windowManager.hyprland = {
  #    enable = true;
  #  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
