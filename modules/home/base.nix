{
  pkgs,
  lib,
  ...
}: {
  home = {
    username = "gordon"; # make these dynamicly set by the importer
    homeDirectory = "/Users/gordon";

    sessionVariables = {
      EDITOR = "nvim";
    };

    activation = {
      linkNeovimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      	ln -sf -t $HOME/.config $HOME/Desktop/dotfiles/nvim
      '';
    };

    packages = with pkgs; [
      fd
      fzf
      git
      ripgrep
      tree
      unzip
      wget
      zip
    ];

    stateVersion = "24.05"; # WARN: DO NOT TOUCH
  };

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      nixd
      alejandra
    ];
  };
}
