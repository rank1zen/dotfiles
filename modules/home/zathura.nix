{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.zathura = {
    enable = true;
    options = {
      window-title-home-tilde = "true";
      window-title-page = "true";
    };
  };
}
