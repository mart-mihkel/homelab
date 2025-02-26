{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    "/media/ssd" = {
      device = "/dev/disk/by-label/ssd";
      fsType = "ext4";
    };

    "/media/hdd" = {
      device = "/dev/disk/by-label/hdd";
      fsType = "ext4";
    };
  };

  swapDevices = [
    { device = "/var/lib/swapfile"; size = 32 * 1024; }
  ];
}
