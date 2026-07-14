                                    # Nonfree standalones.
{ config, pkgs, ... }:              # For 'hubs' and experimental purposes.

{
  programs = {
    steam.enable = true;            # https://wiki.nixos.org/wiki/Steam
  };

  environment = {
    systemPackages = with pkgs; [
      # google-chrome
      # discord-ptb                 # https://wiki.nixos.org/wiki/Discord
    ];
  };
}
