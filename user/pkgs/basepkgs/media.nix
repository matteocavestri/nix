{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #gimp
    gimp-with-plugins
    kdenlive
    inkscape
    obs-studio
    ardour
    mpv
    delfin
    vlc
  ];
}
