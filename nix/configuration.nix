# Nix kernel configuration file.
# For everything OS definitive.

{ config, pkgs, ... }:

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

  nix = {
    nixPath = [                                                     # Configuration paths (defaults listed).
      "nixos-config=/etc/nixos/configuration.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];

    settings.experimental-features = [ "nix-command" "flakes" ];    # Enable flakes.
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;                     # Latest Linux kernel.

    loader = {                                                      # https://nixos.wiki/wiki/Bootloader
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
  };

  users.users = {
    "arborodin" = {                                                 # NOTE: Define <USER>.
      isNormalUser = true;
      description = "♪~";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  networking = {                                                    # https://wiki.nixos.org/wiki/Networking
    hostName = "idofront";                                          # NOTE: Define <HOST>.

    networkmanager = {                                              # https://wiki.nixos.org/wiki/NetworkManager
      enable = true;
      wifi.backend = "iwd";
    };
  };

  services = {
    guix.enable = true;
    # tailscale.enable = true;

    # X11 windowing system.
    xserver = {
      enable = true;
      # Keymap binding.
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    pipewire = {                                                    # https://nixos.wiki/wiki/PipeWire
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };

    printing.enable = true;                                         # https://wiki.nixos.org/wiki/Printing

    desktopManager = {
      plasma6.enable = true;                                        # https://wiki.nixos.org/wiki/KDE
    };

    displayManager = {
      plasma-login-manager.enable = true;                           # https://wiki.nixos.org/wiki/Plasma_Login_Manager

      # autoLogin.user = "";
    };
  };

  security.rtkit.enable = true;                                     # Realtime scheduling priority (recommended for audio).
}
