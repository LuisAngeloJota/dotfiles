{ config, pkgs, ... }:
{
  imports = [
    ./bundle.nix
    ./hardware-configuration.nix
  ];
  system.stateVersion = "24.11";

  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelParams = [
    "mitigations=off"
  ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 0;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  console.useXkbConfig = true;

  environment.systemPackages = with pkgs; [
    anki
    btop
    chromium
    ffmpeg
    git
    imagemagick
    libarchive libreoffice-fresh localsend
    micro mpv-unwrapped
    obs-studio
    rsync
    shotcut
    ventoy
    wireguard-tools
    qpwgraph qbittorrent
    yt-dlp
  ];

  fonts.packages = with pkgs; [
    inter
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  hardware.bluetooth.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";
  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.offload.enableOffloadCmd = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  networking.firewall.enable = false;
  networking.hostName = "X571GT";
  networking.nameservers = [
    "127.0.0.1"
    "::1"
  ];
  networking.timeServers = [
    "time.cloudflare.com"
  ];
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    DriverQuirks = {
      PowerSaveDisable = "rtw_8821ce";
    };
  };

  nixpkgs.config.allowUnfree = true;

  powerManagement.cpuFreqGovernor = "performance";

  security.rtkit.enable = true;

  services.pipewire.alsa.enable = true;
  services.pipewire.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.pulse.enable = true;
  services.printing.enable = true;
  services.thermald.enable = true;
  services.unbound.enable = true;
  services.xserver.videoDrivers = [
    "nvidia"
  ];
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "colemak_dh";

  systemd.coredump.extraConfig = ''
    Storage=none
    ProcessSizeMax=0
  '';

  time.timeZone = "Asia/Manila";

  users.users.la.extraGroups = [
    "wheel"
  ];
  users.users.la.isNormalUser = true;
  users.users.la.initialPassword = "la";

  zramSwap.enable = true;
}
