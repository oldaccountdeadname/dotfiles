{ config, pkgs, ...}: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  home-manager.users.a = { pkgs, ...}: {
    home.file.".background-image".source = ./../assets/bg-flag.png;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome.geary gnome.gnome-contacts gnome.gnome-weather gnome.cheese
    gnome.gedit gnome.gnome-clocks gnome-connections gnome.yelp evince
  ];

  networking.networkmanager.enable = pkgs.lib.mkForce false;
  hardware.pulseaudio.enable = pkgs.lib.mkForce false;
}
