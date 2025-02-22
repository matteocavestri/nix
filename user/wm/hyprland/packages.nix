{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
# Hypr
    waybar 
    eww
    hyprlock
    hyprcursor
    hyprpicker
    hypridle
    hyprpaper
    hyprland-protocols
    inputs.pyprland.packages.${pkgs.system}.pyprland
# Bar, Notification, Launchers
    wlogout
    dunst
    libnotify
    fuzzel
    rofi
# Themes
    numix-cursor-theme
    adwaita-icon-theme
    adwaita-qt
# Controls
    brightnessctl
    pamixer
    grim
    slurp
    killall
    blueman
    wl-clipboard
# Programs
    nautilus
    gnome-calendar
    endeavour
    iotas
    gnome-calculator
    gnome-connections
    evince
    gnome.gnome-software
    eog
    alacritty
    kitty
    ranger
    mpd
    mpc-cli
# xdg desktop
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    gsettings-desktop-schemas
# Wayland
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
# Utility
    feh
    killall
    libinput-gestures
    gnome.gvfs
    flameshot
# Services


    gobject-introspection
    glib

    tmux
    xorg.xev
    tree
    libva-utils
    zenity
    wlr-randr
    wtype
    ydotool
    fnott
    keepmenu
    wev
    wlsunset
    nwg-launchers
  ]; 
}
