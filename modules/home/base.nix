{
  inputs,
  pkgs,
  ...
}: {
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
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

    stateVersion = "24.05";
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "gordon";
      userEmail = "gordonchen2014@gmail.com";
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      extraPackages = with pkgs; [
        nixd
        alejandra
        lua-language-server
        stylua
      ];
    };
  };

  xdg = {
    enable = true;

    configFile = {
      nvim = {
        source = ../../nvim;
      };
    };
  };
}
