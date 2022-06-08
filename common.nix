{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.firewall.allowedTCPPorts = [ 80 443 1965 ];

  systemd.mounts = [
    {
      what = "hub.marx:/nas/remote";
      where = "/mnt/remote";
      type = "nfs";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
    }
    {
      where = "/mnt/public";
      what = "hub.marx:/nas/public";
      type = "nfs";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" "network.target" ];
      after = [ "network-online.target" "network.target" ];
    }
  ];

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.libinput.enable = true;

  services.printing.enable = true;

  services.cron.enable = true;
  services.cron.systemCronJobs = [
    "* * * * * a torsocks mbsync -a"
    "10 * * * * root systemctl restart tor.service"
  ];

  services.gnome.gnome-keyring.enable = true;

  sound.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  services.tor.enable = true;

  users.users.a = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.theme = "sunrise";
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.shellAliases = {
    "nd" = "nix develop --command zsh";
    "nb" = "nix build";
  };

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.homeBinInPath = true;
  environment.variables = {
    "EDITOR" = "vi";

    "LANGSERV_CC" = "${pkgs.clang-tools}/bin/clangd";
    "LANGSERV_HK" = "${pkgs.haskell-language-server}/bin/haskell-language-server";
  };

  fonts.fonts = with pkgs; [ fira-code source-sans source-serif ];
  environment.systemPackages = with pkgs; [
    man-pages man-pages-posix bintools gnumake gcc ghc valgrind nvi
    clang-tools python39Packages.python-lsp-server haskell-language-server
    nfs-utils qemu
    neofetch gitFull torsocks mu mutt isync pulsemixer libnotify
    xclip kitty zathura feh polybar firefox

    texlive.combined.scheme-medium ispell

    skypeforlinux discord

    (import ./emacs.nix { inherit pkgs; })
  ];

  programs.gnupg.agent.enable = true;

  documentation.dev.enable = true;

  system.stateVersion = "21.11";
}

