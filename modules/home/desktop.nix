{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # hyprland things
      slurp
      grim
      fuzzel
      wl-clipboard
      swww
      wlsunset

      hyprland
    ];
    #
    # # DO NOT TOUCH
    # stateVersion = "24.05";
  };

  xdg = {
    enable = true;

    userDirs.enable = true;
    userDirs.createDirectories = true;
  };

  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        eval "$(direnv hook bash)"
      '';
    };
    fish = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zathura = {
      enable = true;
      options = {
        window-title-home-tilde = "true";
        window-title-page = "true";
      };
    };
    foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=12";
          dpi-aware = true;
          pad = "20x10";
        };
      };
    };
    qutebrowser = {
      enable = true;
      searchEngines = {
        youtube = "https://www.youtube.com/results?search_query={}";
        wikipedia = "https://en.wikipedia.org/wiki/Special:Search/{}";
        math-stackexchange = "https://math.stackexchange.com/search?q={}";
        reddit = "https://www.reddit.com/search/?q={}";
        github = "https://github.com/search?q={}";
        google = "https://www.google.com/search?q={}";

        # On the chopping block
        archwiki = "https://wiki.archlinux.org/title/Special:Search/{}";
        archpackages = "https://archlinux.org/packages/?q={}";
        nixpkgs = "https://search.nixos.org/packages?query={}";
        nixos = "https://search.nixos.org/options?query={}";
      };
      keyBindings = {
        normal = {
          "<Ctrl-o>" = "tab-focus stack-prev";
          "<Ctrl-i>" = "tab-focus stack-next";

          "ey" = ":cmd-set-text :tab-focus https://www.youtube.com";
          "eq" = ":cmd-set-text :tab-focus https://q.utoronto.ca";
        };
      };
      extraConfig = ''
        # config.source('/home/gordo/nix-cfg/qutebrowser/config.py')
      '';
    };
  };
}
