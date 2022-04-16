{ config, ... }: {
  home-manager.useGlobalPkgs = true;

  home-manager.users.a = { pkgs, ... }: {
    home.file.".ispell_english".source = ./assets/ispell-dict;

    home.file.".emacs.d/init.el".source = ./assets/emacs.init.el;

    home.file.".config/kitty" = {
      source = ./assets/kitty;
      recursive = true;
    };

    home.file.".config/gmail-pass.gpg".source = ./assets/gmail-pass.gpg;

    home.file.".mbsyncrc".source = ./assets/isync.conf;
    home.file.".config/mutt" = {
      source = ./assets/mutt;
      recursive = true;
    };

    home.file.".config/picom/picom.conf".source = ./assets/picom;
  };
}
