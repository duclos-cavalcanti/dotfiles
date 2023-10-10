{   config, lib, pkgs, modulesPath ... }:

{
    boot = {
        initrd.availableKernelModules = [ "ext4" "usbmon" "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
        initrd.kernelModules = [ ];
        kernelModules = [ ];
        extraModulePackages = [ ];
    };

    fileSystems."/boot/efi" = {
       device = "/dev/disk/by-label/EFI";  # Use the labeled EFI partition
       fsType = "vfat";  # EFI partition type is vfat
     };

    fileSystems."/" = {
       device = "/dev/disk/by-label/root";  # Use the labeled root partition
       fsType = "ext4";
     };

    fileSystems."swap" = {
      device = "/dev/sda3";  # Use the labeled swap partition
      fsType = "swap";
    };
}
