{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  # (DON'T) Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.enable = true;
  
  # Printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip pkgs.hplipWithPlugin ];
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
  users.users.bananachu.extraGroups = [ "lp" "scanner" ];
#  hardware.printers = {
#  ensurePrinters = [
#      {
#        name = "Deskjet_1050_J410_series";
#        location = "Home";
#        deviceUri = "usb://HP/Deskjet%201050%20J410%20series?serial=CN1AI1N5YT05QT&interface=1";
#        model = "hp-deskjet_1050_j410_series.ppd.gz";
#        ppdOptions = {
#          PageSize = "A4";
#        };
#      }
#    ];
#  };

  # SDDM and Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.gnupg.agent.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "latin9_nodeadkeys";
  };
  
  programs.hyprland.enable = true;
  programs.steam.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # vulkan
  #hardware.extraPackages = with pkgs; [
  #  amdvlk
  #];
  # For 32 bit applications 
  #hardware.extraPackages32 = with pkgs; [
  #  driversi686Linux.amdvlk
  #];
}
