{ config, ... }: {
  home-manager.useGlobalPkgs = true;

  home-manager.users.a = { pkgs, ... }: {
    home.file.".ispell_english".source = ./assets/ispell-dict;

    home.file.".emacs.d/init.el".source = ./assets/emacs.init.el;

    home.file.".config/amp" = {
      source = ./assets/amp;
      recursive = true;
    };

    home.file.".config/kitty" = {
      source = ./assets/kitty;
      recursive = true;
    };

    home.file.".mbsyncrc".source = ./assets/isync.conf;
    home.file.".config/mutt" = {
      source = ./assets/mutt;
      recursive = true;
    };

    home.file.".config/picom/picom.conf".source = ./assets/picom;
  };

  home-manager.users.root = { pkgs, ... }: {
    home.file.".config/amp" = {
      source = ./assets/amp;
      recursive = true;
    };
  };
}
