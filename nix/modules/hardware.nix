{   config, ... }:

{
    environment.systemPackages = with pkgs; [
        intel-ucode
    ];

    # Enable Intel microcode updates for improved CPU stability and security
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Set Intel graphics driver for the integrated GPU
    hardware.opengl.driSupport32Bit = true;
    hardware.opengl.enable = true;
    hardware.opengl.extraPackages = with pkgs; [
      intel-media-driver
      libva-intel-driver
      libva-utils
    ];

    kernelModules = [ "kvm-intel" ];

    # Enable Intel CPU microcode updates
    boot.kernelParams = [ "intel_iommu=on" ];

    hardware.cpu.intel.updateMicrocode = true;
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;

    sound.enable = true;
    hardware.bluetooth.enable = true;
}

