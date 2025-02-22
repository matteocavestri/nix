{ pkgs, ... }:

{
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
     enableSSHSupport = true;
  };
  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-gtk2
  ];
}
