# System configuration file.
# For everything software definitive.

{ config, pkgs, ... }:

{
  imports = [
    # Hardware scan results.
    ./hardware-configuration.nix

    # Programs and packages.
    ./applications.nix

    # Mozilla declaration.
    ./mozilla.nix
  ];

  boot = {
    # Bootloader.
    # https://nixos.wiki/wiki/Bootloader
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      # Systemd.
      # https://wiki.nixos.org/wiki/Systemd
      systemd-boot.enable = false;

      # GRUB.
      # https://wiki.nixos.org/wiki/GNU_GRUB
      grub = {
        device = "nodev";
        enable = true;
        efiSupport = true;
        useOSProber = true;
        extraEntriesBeforeNixOS = false;
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
          menuentry "Firmware" {
            fwsetup
          }
        '';
      };
    };

    # Latest Linux kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # System version.
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";

  nix = {
    # Experimental features.
    settings.experimental-features = [ "nix-command" "flakes" ];

    # Explicit pathing.
    nixPath = [
      "nixos-config=/etc/nixos/configuration.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Timezone.
  time.timeZone = "Europe/Rome";

  # Internationalisation.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # Account.
  users.users = {
    # NOTE: Define <USER>.
    arborodin = {
      isNormalUser = true;
      description = "♪~";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # Connectivity.
  networking = {
    # NOTE: Define <HOST>.
    hostName = "idofront";

    # Network Manager.
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    # Wireless support via wpa_supplicant.
    wireless = {
      enable = false;
      networks = {
        "name" = { psk = "password"; };
      };
    };

    # Loopback explicit routing.
    interfaces = {
      lo = {
        ipv4.addresses = [{
          address = "127.0.0.1";
          prefixLength = 8;
        }];
        ipv6.addresses = [{
          address = "::1";
          prefixLength = 128;
        }];
      };
    };

    # OpenSSH daemon (can't be disabled; comment out).
    # openssh.enable = true;

    # Firewall (enabled automatically).
    # firewall = {
    #   enable = false;
    #   allowedTCPPorts = [ ... ];
    #   allowedUDPPorts = [ ... ];
    # };

    # Proxy.
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  # Realtime scheduling priority to user processes on demand.
  # Optional but recommended for PulseAudio and PipeWire.
  security.rtkit.enable = true;

  services = {
    # Guix daemon.
    guix.enable = true;

    # X11 windowing system.
    xserver = {
      enable = true;
      # Keymap binding.
      xkb = {
        layout = "us";
        variant = "";
      };
      # Touchpad support (enabled default in most desktopManager).
      # libinput.enable = true;
    };

    # PipeWire sound.
    # https://nixos.wiki/wiki/PipeWire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # To use JACK applications, uncomment this:
      # jack.enable = true;

      # Use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now).
      # media-session.enable = true;
    };

    # CUPS document printing.
    printing.enable = true;

    # KDE Plasma & Login Manager.
    desktopManager = {
      # https://wiki.nixos.org/wiki/KDE
      plasma6.enable = true;
    };
    displayManager = {
      # autoLogin.user = "arborodin";

      # https://wiki.nixos.org/wiki/Plasma_Login_Manager
      # plasma-login-manager.enable = true;
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
