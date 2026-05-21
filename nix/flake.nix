{
  description = "Arborodin's Flake";
    # Resources used:
    #   https://wiki.nixos.org/wiki/Flakes
    #   https://borretti.me/article/nixos-for-the-impatient
    #   https://github.com/ryan4yin/nixos-and-flakes-book
    #   https://github.com/Misterio77/nix-starter-configs

  inputs = {
    # Default to nixos-unstable branch.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Latest stable branch of nixpkgs; for version rollback.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager declaration.
    # https://wiki.nixos.org/wiki/Home_Manager
    # home-manager.url = "github:nix-community/home-manager/release-25.05";

    # Wayland declaration.
    # https://nixos.wiki/wiki/Wayland
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # Hyprland declaration.
    # https://wiki.nixos.org/wiki/Hyprland
    # https://wiki.hypr.land/Nix/Hyprland-on-NixOS
    # hyprland.url = "github:hyprwm/Hyprland/v0.55.0";

    # Catpuccin declaration.
    # https://nix.catppuccin.com/getting-started/flakes/
    # catppuccin.url = "github:catppuccin/nix";

    # Zen Browser declaration.
    # https://wiki.nixos.org/wiki/Zen_Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";

    # Alejandra declaration.
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";

    # Nil declaration.
    nil.url = "github:oxalica/nil";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    systems = [
      "i686-linux"
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    # This is a function that generates an attribute by calling a function
    # you pass to it, with each system as an argument.
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # NixOS configuration entrypoint.
    # $ nixos-rebuild --flake .#hostname
    nixosConfigurations = {
      # NOTE: Define <HOST>.
      idofront = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

          # catppuccin.nixosModules.catppuccin

          ({pkgs, config, ... }: {
            config = {
              nix.settings = {
                trusted-public-keys = [
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                ];
                substituters = [
                  "https://cache.nixos.org"
                  "https://nixpkgs-wayland.cachix.org"
                ];
              };

              nixpkgs.overlays = [
                # inputs.nixpkgs-wayland.overlay
              ];
              environment.systemPackages = [
                # inputs.nixpkgs-wayland.packages.${system}.wev
              ];
            };
          })
        ];
      };
    };

    # Standalone home-manager configuration entrypoint.
    # $ home-manager --flake .user@host
    homeConfigurations = {
      # NOTE: define <USER@HOST>.
      "arborodin@idofront" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance.
        # NOTE: Define architecture.
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          # Main home-manager configuration file.
          ./home.nix
        ];
      };
    };
  };
}
