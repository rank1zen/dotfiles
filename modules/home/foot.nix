{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=12";
        dpi-aware = true;
        pad = "20x10";
      };
    };
  };
}
