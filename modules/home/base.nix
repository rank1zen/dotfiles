{
  pkgs,
  lib,
  ...
}: {
  home = {
    username = "gordo"; # make these dynamicly set by the importer
    homeDirectory = "/home/gordo";

    sessionVariables = {
      EDITOR = "nvim";
    };

    activation = {
      linkMyStuff = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ln -sf -t $HOME/.config $HOME/nix-cfg/nvim
      '';
    };

    packages = with pkgs; [
      fd
      fzf
      git
      home-manager
      ripgrep
      tree
      unzip
      wget
      zip
    ];

    stateVersion = "24.05"; # WARN: DO NOT TOUCH
  };

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
