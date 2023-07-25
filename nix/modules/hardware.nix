{   config, ... }:

{
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

    # Enable Intel CPU microcode updates
    boot.kernelParams = [ "intel_iommu=on" ];

    sound.enable = true;
    hardware.bluetooth.enable = true;
}

