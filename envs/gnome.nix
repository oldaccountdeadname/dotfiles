{ config, pkgs, ...}: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  home-manager.users.a = { pkgs, ...}: {
    home.file.".background-image".source = ./../assets/bg-flag.png;
  };

  networking.networkmanager.enable = pkgs.lib.mkForce false;
  hardware.pulseaudio.enable = pkgs.lib.mkForce false;
}