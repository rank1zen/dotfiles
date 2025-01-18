{pkgs, ...}: {
  imports = [
    ./defaults/qutebrowser.nix
  ];
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
          font = "JetBrains Mono:size=10";
          dpi-aware = true;
          pad = "20x10";
        };
      };
    };
    ghostty = {
      enable = true;
    };
    qutebrowser = {
      enable = true;
    };
  };
}
