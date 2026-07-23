                                                # Standalones.
{ config, pkgs, lib, ... }:                     # For everything DE integrative.

{
  imports = [
    # ./mozilla.nix
  ];

  programs = {
    # mtr.enable = true;                        # SUID wrappers.
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    firefox.enable = true;                      # https://wiki.nixos.org/wiki/Firefox
    hyprland.enable = true;                     # https://wiki.nixos.org/wiki/Hyprland      # https://wiki.hypr.land/Nix
    niri.enable = true;                         # https://wiki.nixos.org/wiki/Niri
    git.enable = true;                          # https://wiki.nixos.org/wiki/Git
    mosh.enable = false;                        # https://wiki.nixos.org/wiki/Mosh
    kdeconnect.enable = false;                  # https://wiki.nixos.org/wiki/KDE_Connect
    steam.enable = true;                        # https://wiki.nixos.org/wiki/Steam         # https://wiki.nixos.org/wiki/Games
    yazi.enable = false;                        # https://wiki.nixos.org/wiki/Yazi

    appimage = {                                # https://wiki.nixos.org/wiki/Appimage
      enable = true;
      binfmt = true;
    };

    neovim = {                                  # https://nixos.wiki/wiki/Neovim
      enable = true;
      defaultEditor = true;
    };

    tmux = {                                    # https://nixos.wiki/wiki/Tmux
      enable = false;
      clock24 = true;
    };

    foot = {
      enable = false;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    zsh = {                                     # https://wiki.nixos.org/wiki/Zsh
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
      setOptions = [ "HIST_IGNORE_ALL_DUPS" ];
    };

    obs-studio = {                              # https://wiki.nixos.org/wiki/OBS_Studio
      enable = false;

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi                               # AMD hardware acceleration (optional).
        obs-gstreamer
        obs-vkcapture
        ];

      package = ( pkgs.obs-studio.override {    # Nvidia hardware acceleration (optional).
        cudaSupport = true;
      });
    };
  };

  environment = {
    systemPackages = with pkgs; [               # https://search.nixos.org/packages
      efibootmgr
      exfatprogs
      gparted
      deno
      curl
      wget
      yt-dlp
      aria2
      qbittorrent
      # localsend
      # rofi
      vicinae                                   # https://blog.ricardof.dev/vicinae-the-everything-launcher-for-linux/
      flameshot                                 # https://wiki.nixos.org/wiki/Flameshot
      # grim
      # gifski
      # tree
      kitty                                     # https://wiki.nixos.org/wiki/Kitty
      # ghostty
      vim                                       # https://nixos.wiki/wiki/Vim
      vscodium                                  # https://nixos.wiki/wiki/VSCodium
      zathura
      mpv                                       # https://wiki.nixos.org/wiki/MPV
      freetube
      libreoffice-qt6-fresh                     # https://nixos.wiki/wiki/LibreOffice
      gimp
      krita
      # audacity
      joplin-cli
      joplin-desktop
      element-desktop
      # chromium                                # https://wiki.nixos.org/wiki/Chromium
      legcord                                   # https://wiki.nixos.org/wiki/Discord
      ruffle
      ppsspp
      rpcs3
      # mullvad                                 # https://wiki.nixos.org/wiki/Mullvad_VPN
      # mullvad-vpn
      # mullvad-browser
      winetricks                                # https://nixos.wiki/wiki/Wine
      wineWow64Packages.stable
      wineWow64Packages.staging
      wineWow64Packages.waylandFull
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
    etc = {
      # "nextcloud-admin-pass".text = "";
    };
  };
}
