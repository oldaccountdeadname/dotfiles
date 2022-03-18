{ config, pkgs, ... }: {
  services.xserver.windowManager.cwm.enable = true;
  services.xserver.displayManager.startx.enable = true;

  environment.systemPackages = with pkgs; [ picom ];

  home-manager.users.a = { pkgs, ... }: {
    home.file."bin/cwm.sh" = {
      source = ./../assets/cwm.sh;
      executable = true;
    };

    home.file.".cwmrc".source = ./../assets/cwmrc;
    home.file.".xinitrc".source = ./../assets/xinitrc;
    home.file."doc/bg.png".source = ./../assets/bg.png;

    home.file.".config/picom/picom.conf".source = ./../assets/picom;
  };
}
