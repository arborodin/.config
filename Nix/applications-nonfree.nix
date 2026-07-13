{ config, pkgs, ... }:              # Nonfree standalones.

{
  programs = {
    steam.enable = true;            # https://wiki.nixos.org/wiki/Steam
  };

  environment = {
    systemPackages = with pkgs; [
      # google-chrome
      discord-ptb                   # https://wiki.nixos.org/wiki/Discord
    ];
  };
}
