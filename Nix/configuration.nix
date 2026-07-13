                                                                    # Nix kernel configuration file.
{ config, pkgs, ... }:                                              # For everything OS definitive.

{
  imports = [
    ./hardware-configuration.nix
    ./applications.nix
  ];

  system.stateVersion = "26.05";                                    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  nixpkgs.config.allowUnfree = true;                                # https://www.fsf.org/about

  time.timeZone = "Europe/Rome";

  i18n = {
    defaultLocale = "en_GB.UTF-8";                                  # https://wiki.nixos.org/wiki/Locales
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
    };
  };

  console = {
    keyMap = "us,ru";
    font = "Lat2-Terminus16";                                       # https://wiki.nixos.org/wiki/Console_Fonts
  };

  nix = {
    nixPath = [                                                     # Nix schema (default paths listed).
      "nixos-config=/etc/nixos/configuration.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];

    settings.experimental-features = [ "nix-command" "flakes" ];    # https://wiki.nixos.org/wiki/Flakes
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;                     # Latest Linux kernel.

    loader = {                                                      # https://wiki.nixos.org/wiki/Bootloader
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {                                                      # https://wiki.nixos.org/wiki/GNU_GRUB
        device = "nodev";
        enable = true;
        efiSupport = true;
        useOSProber = true;
        extraEntriesBeforeNixOS = false;
        extraEntries = ''
          menuentry "Reboot"   { reboot  }
          menuentry "Poweroff" { halt    }
          menuentry "Firmware" { fwsetup }
        '';
      };
    };
  };

  users.users = {
    "arborodin" = {                                                 # NOTE: Define <USER>.
      isNormalUser = true;
      description = "♪~";
      extraGroups = [ "root" "wheel" "networkmanager" ];            # NOTE: Use "root" at your own risk!
    };
  };

  networking = {                                                    # https://wiki.nixos.org/wiki/Networking
    hostName = "idofront";                                          # NOTE: Define <HOST>.

    networkmanager = {                                              # https://wiki.nixos.org/wiki/NetworkManager
      enable = true;
      wifi.backend = "iwd";
    };
  };

  hardware = {
    bluetooth.enable = true;                                        # https://wiki.nixos.org/wiki/Bluetooth
  };

  services = {
    xserver = {                                                     # https://wiki.nixos.org/wiki/Xorg
      xkb.layout = "us,ru";                                         # https://wiki.nixos.org/wiki/Keyboard_Layout_Customization
    };

    desktopManager = {
      plasma6.enable = true;                                        # https://wiki.nixos.org/wiki/KDE
    };

    displayManager = {
      plasma-login-manager.enable = true;                           # https://wiki.nixos.org/wiki/Plasma_Login_Manager

      # autoLogin.user = "";
    };

    pipewire = {                                                    # https://wiki.nixos.org/wiki/PipeWire
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };

    printing.enable = true;                                         # https://wiki.nixos.org/wiki/Printing

    guix.enable = true;                                             # https://fzakaria.com/2026/06/05/the-guix-nix-abomination-leveraging-guix-derivations-in-nix
    flatpak.enable = true;                                          # https://wiki.nixos.org/wiki/Flatpak
    # tailscale.enable = true;                                      # https://wiki.nixos.org/wiki/Tailscale
    syncthing = {                                                   # https://wiki.nixos.org/wiki/Syncthing
      enable = true;
      openDefaultPorts = true;
    };
  };

  security.rtkit.enable = true;                                     # Realtime scheduling priority (recommended for audio).
}
