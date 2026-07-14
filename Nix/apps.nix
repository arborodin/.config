                                            # Standalones.
{ config, pkgs, ... }:                      # For everything DE integrative.

{
  imports = [
    # ./mozilla.nix
  ];

  # Programs to install in system profile.
  programs = {
    # Firefox (temporary).
    firefox.enable = true;

    # Hyprland.
    # https://wiki.nixos.org/wiki/Hyprland
    # https://wiki.hypr.land/Nix/
    hyprland.enable = true;

    # Niri
    # https://wiki.nixos.org/wiki/Niri
    niri.enable = true;

    # Git.
    # https://wiki.nixos.org/wiki/Git
    git.enable = true;

    # Mosh.
    # https://wiki.nixos.org/wiki/Mosh
    mosh.enable = false;

    # Zsh.
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

    # Yazi.
    # https://wiki.nixos.org/wiki/Yazi
    yazi.enable = false;

    # Neovim.
    # https://nixos.wiki/wiki/Neovim
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Foot.
    foot = {
      enable = false;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      };

    # Tmux.
    # https://nixos.wiki/wiki/Tmux
    tmux = {
      enable = false;
      clock24 = true;
    };

    # OBS.
    # https://wiki.nixos.org/wiki/OBS_Studio
    obs-studio = {
      enable = false;

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi # AMD hardware acceleration (optional).
        obs-gstreamer
        obs-vkcapture
        ];

      # Nvidia hardware acceleration (optional).
      package = ( pkgs.obs-studio.override {
        cudaSupport = true;
      });
    };

    # KDE Connect.
    # https://wiki.nixos.org/wiki/KDE_Connect
    kdeconnect.enable = false;

    # SUID wrappers.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };

  environment = {
    systemPackages = with pkgs; [   # https://search.nixos.org/packages
      efibootmgr
      gparted
      deno
      curl
      wget
      yt-dlp
      aria2
      qbittorrent
      # localsend
      # rofi
      vicinae                       # https://blog.ricardof.dev/vicinae-the-everything-launcher-for-linux/
      flameshot                     # https://wiki.nixos.org/wiki/Flameshot
      # grim
      # gifski
      # tree
      kitty                         # https://wiki.nixos.org/wiki/Kitty
      # ghostty
      vim                           # https://nixos.wiki/wiki/Vim
      vscodium                      # https://nixos.wiki/wiki/VSCodium
      zathura
      mpv                           # https://wiki.nixos.org/wiki/MPV
      freetube
      libreoffice-qt6-fresh         # https://nixos.wiki/wiki/LibreOffice
      gimp
      krita
      # audacity
      element-desktop
      ruffle
      ppsspp
      rpcs3
      # mullvad                     # https://wiki.nixos.org/wiki/Mullvad_VPN
      # mullvad-vpn
      # mullvad-browser
      winetricks                    # https://nixos.wiki/wiki/Wine
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
  };
}
