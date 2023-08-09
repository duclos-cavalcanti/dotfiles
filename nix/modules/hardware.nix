{   config, lib, pkgs, modulesPath ... }:

{
    environment.systemPackages = with pkgs; [
        intel-ucode
    ];

    hardware.cpu.intel.updateMicrocode = true;

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        # Enable Intel CPU microcode updates
        kernelParams = [ "intel_iommu=on" ];

        # systemd and EFI
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true; 

        # Required for the root file system type and other modules
        initrd.availableKernelModules = [ "ext4" "usbmon" "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    };

    kernelModules = [ 
        "kvm-intel" 
    ];

    # Set Intel graphics driver for the integrated GPU
    hardware.opengl.driSupport32Bit = true;
    hardware.opengl.enable = true;
    hardware.opengl.extraPackages = with pkgs; [
        mesa
        intel-media-driver
        libva-intel-driver
        libva-utils
        vulkan-loader
        vulkan-tools
    ];
    
    # Use Intel integrated graphics
    services.xserver.videoDrivers = [ "intel" ];

    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;

    sound.enable = true;
    hardware.bluetooth.enable = true;

    fileSystems."/boot/efi" = {
       device = "/dev/disk/by-label/EFI";  # Use the labeled EFI partition
       fsType = "vfat";  # EFI partition type is vfat
     };

    fileSystems."/" = {
       device = "/dev/disk/by-label/root";  # Use the labeled root partition
       fsType = "ext4";
     };

    fileSystems."swap" = {
      device = "/dev/disk/by-label/swap";  # Use the labeled swap partition
      fsType = "swap";
    };
}

