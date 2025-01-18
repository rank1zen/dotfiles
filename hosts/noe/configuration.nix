{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
  };
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users = {
    gordo = {
      isNormalUser = true;
      extraGroups = [
        "docker"
        "networkmanager"
        "wheel"
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  services = {
    dockerRegistry = {
      enable = true;
    };
    openssh = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      inter
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      # subpixel.lcdfilter = "light";
      # hinting.style = "full";
      defaultFonts = {
        serif = [
          "Noto Serif"
        ];
        sansSerif = [
          "Inter"
          "DejaVu Sans"
        ];
        monospace = [
          "JetBrains Mono"
          "DejaVu Sans Mono"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      git
    ];
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  system.stateVersion = "24.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
