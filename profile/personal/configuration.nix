{ pkgs, userSettings, systemSettings, ... }:

{
# Shell configuration
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  imports = [
# Default imports
    (./. + "../../../hardware"+("/"+systemSettings.hardware)+"/config.nix") # Hardware Import
    ../../system/security/gpg.nix # GPG config
    ../../system/config/fonts.nix # Fonts Config
    ../../system/config/systemd.nix # Systemd config
    ../../system/config/users.nix # Users config
    (./. + "../../../system/wm"+("/"+userSettings.wm)+".nix") # Window manager import

    ../../system/pkgs/base.nix # Base pkgs definition
    ../../system/pkgs/gaming.nix # Gaming pkgs
    ../../system/pkgs/flatpak.nix # Flatpak support
    ../../system/pkgs/container.nix # Container definition
    ../../system/pkgs/virtualization.nix # KVM/QEMU definition
  ];
}
