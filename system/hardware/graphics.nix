{ config, lib, pkgs, ... }:

{
  hardware = {
    graphics.enable = true;
  };
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];
}
