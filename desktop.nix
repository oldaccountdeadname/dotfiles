{ config, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "nixos-desktop";
  networking.wireless = {
    enable = true;
    networks.MaximumWarp-5g = {
      pskRaw = "a9dbe103c149561c4bef6ccf7cfaaa2e82434010da360471543a960fd333605a";
    };
  };

  networking.interfaces.wlp6s0.useDHCP = true;
  networking.nameservers = [ "192.168.0.2" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9c2eaaeb-d160-4c96-93f9-b8e91e90a54a";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/31C5-6B52";
    fsType = "vfat";
  };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  hardware.video.hidpi.enable = true;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  home-manager.users.a = { pkgs, ... }: {
    home.file.".config/polybar/config".source = ./assets/polybar-desktop.ini;
  };
}
