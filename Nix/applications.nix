# Since applications are dynamic and standalone,
# programs and packages are declared in this file.
# Nonfree applications are contained separately.

{ config, pkgs, ... }:

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

    # Some programs need SUID wrappers.
    # Can be configured further or are started in user sessions.
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
      efibootmgr
      gparted
      deno
      curl
      wget
      yt-dlp
      aria2
      qbittorrent
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
      winetricks
      wineWow64Packages.stable      # https://nixos.wiki/wiki/Wine
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
