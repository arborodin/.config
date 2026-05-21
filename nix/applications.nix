# Since applications are dynamic and standalone,
# programs and packages are declared in this file.
# Nonfree applications are contained separately.

{ config, pkgs, ... }:

{
  # Programs to install in system profile.
  programs = {
    # Git declaration.
    # https://wiki.nixos.org/wiki/Git
    git.enable = true;

    # Zsh declaration.
    # https://wiki.nixos.org/wiki/Zsh
    zsh = {
      enable = false;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        theme = "afowler";
        plugins = [
          "git"
          "z"
        ];
      };

      shellAliases = {
        ll = "ls -l";
        edit = "sudo -e";
        update = "sudo nixos-rebuild switch";
      };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
      ];
    };

    # Neovim declaration.
    # https://nixos.wiki/wiki/Neovim
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Hyprland declaration.
    # https://wiki.nixos.org/wiki/Hyprland
    # https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
    hyprland = {
      enable = false;
      xwayland.enable = true;
      withUWSM = true;
    };

    # Foot declaration.
    foot = {
      enable = false;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      };

    # Tmux declaration.
    # https://nixos.wiki/wiki/Tmux
    tmux = {
      enable = false;
      clock24 = true;
    };

    # OBS declaration.
    # https://wiki.nixos.org/wiki/OBS_Studio
    obs-studio = {
      enable = false;

      # Nvidia hardware acceleration (optional).
      package = ( pkgs.obs-studio.override {
        cudaSupport = true;
      });

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi # AMD hardware acceleration (optional).
        obs-gstreamer
        obs-vkcapture
        ];
      };

    # KDE Connect declaration.
    # https://wiki.nixos.org/wiki/KDE_Connect
    kdeconnect.enable = false;

    # Some programs need SUID wrappers; can be configured further
    # or are started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };

  environment = {
    # Packages to install in system profile.
    # https://search.nixos.org/packages
    systemPackages = with pkgs; [
      # GParted declaration.
      gparted

      # EFIBootMgr declaration.
      efibootmgr

      # Wget declaration.
      wget

      # Curl declaration.
      curl

      # YT-dlp declaration.
      yt-dlp

      # Tree declaration.
      # tree

      # Swaybg declaration.
      # swaybg

      # Flameshot declaration.
      # https://wiki.nixos.org/wiki/Flameshot
      # grim
      # flameshot

      # Vim declaration.
      # https://nixos.wiki/wiki/Vim
      vim

      # VSCodium declaration.
      # https://nixos.wiki/wiki/VSCodium
      vscodium

      # Kitty declaration.
      # https://wiki.nixos.org/wiki/Kitty
      kitty

      # Ghostty declaration.
      # ghostty

      # MPV declaration.
      # https://wiki.nixos.org/wiki/MPV
      mpv

      # Zathura declaration.
      zathura

      # LibreOffice declaration.
      # https://nixos.wiki/wiki/LibreOffice
      libreoffice-qt6-fresh

      # GIMP declaration.
      gimp

      # Audacity declaration.
      # audacity

      # Aria2 declaration.
      aria2

      # QBittorrent declaration.
      qbittorrent

      # Mullvad declaration.
      # https://wiki.nixos.org/wiki/Mullvad_VPN
      # mullvad
      # mullvad-vpn
      # mullvad-browser

      # Matrix declaration.
      element-desktop

      # Ruffle declaration.
      ruffle

      # PPSSPP declaration.
      ppsspp

      # RPCS3 declaration.
      rpcs3

      # Wine declaration.
      # https://nixos.wiki/wiki/Wine
      wineWow64Packages.stable
      wineWow64Packages.staging
      wineWow64Packages.waylandFull
      winetricks

      # KDE Packages declaration.
      # kdePackages.ark
      # kdePackages.kate
      # kdePackages.konsole
      # kdePackages.yakuake
      # kdePackages.dolphin
      # kdePackages.kdenlive
    ];
    variables = {
      EDITOR = "nvim";
    };
  };
}
