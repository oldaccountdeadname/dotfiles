{ config, ... }: {
  home-manager.useGlobalPkgs = true;

  home-manager.users.a = { pkgs, ... }: {
    home.file.".xinitrc".source = ./assets/xinitrc;
    home.file.".cwmrc".source = ./assets/cwmrc;
    home.file."doc/bg.png".source = ./assets/bg.png;

    home.file.".config/amp" = {
      source = ./assets/amp;
      recursive = true;
    };

    home.file.".config/kitty" = {
      source = ./assets/kitty;
      recursive = true;
    };

    home.file.".config/mutt" = {
      source = ./assets/mutt;
      recursive = true;
    };

    home.file.".config/picom/picom.conf".source = ./assets/picom;

    home.file."bin/cwm.sh" = {
      source = ./assets/cwm.sh;
      executable = true;
    };
  };

  home-manager.users.root = { pkgs, ... }: {
    home.file.".config/amp" = {
      source = ./assets/amp;
      recursive = true;
    };
  };
}
