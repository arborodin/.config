# Mozilla configuration.
# https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/19

{ config, pkgs, ... }:

{
  programs = {
    # Firefox declaration.
    # https://nixos.wiki/wiki/Firefox
    firefox = {
      enable = true;
      languagePacks = [ "ru" "en-US" ];

      # Profiles.
      # about:profiles
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      profiles = {
          profile_0 = {       # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
          id = 0;             # 0 is the default profile; see also option "isDefault"
          isDefault = true;   # can be omitted; true if profile ID is 0
          name = "profile_0"; # name as listed in about:profiles
          settings = {        # specify profile-specific preferences here; check about:config for options
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            "browser.startup.homepage" = "https://nixos.org";
            "browser.newtabpage.pinned" = [{
              title = "NixOS";
              url = "https://nixos.org";
            }];
          };
        };
      };

      package = with pkgs;
        librewolf
        wrapFirefox
        firefox-unwrapped
      {
        # Policies.
        # about:policies#documentation
        extraPolicies = {
          # Privacy.
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };

          # Accounts.
          DisableAccounts = false;
          DisableFirefoxAccounts = false;
          DisableFirefoxScreenshots = true;
          DisablePocket = true;

          # Browsing.
          DontCheckDefaultBrowser = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DisplayBookmarksToolbar = "always"; # "always" "never" "newtab"
          DisplayMenuBar = "default-off";     # "always" "never" "default-on" "default-off"
          SearchBar = "unified";              # "unified" "separate"

          # Extensions.
          # about:support
          ExtensionSettings = with builtins;
          let extension = shortID: UUID: {
            name = UUID;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortID}/latest.xpi";
              installation_mode = "normal_installed"; # "allowed" "blocked" "force_installed" "normal_installed"
            };
          };
          in listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "duckduckgo-no-ai-search" "noai@duckduckgo.com")
            (extension "duckduckgo-for-firefox" "jid1-ZAdIEUB7XOzOJw@jetpack")
          ];

          # Preferences.
          # about:config
          Preferences = {
            # Enable WebGL.
            "webgl.disabled" = false;

            # Block cookie banners.
            "cookiebanners.service.mode" = 2;
            "cookiebanners.service.mode.privateBrowsing" = 2;

            # Privacy.
            "privacy.resistFingerprinting" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.emailtracking.enabled" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.donottrackheader.enabled" = true;
            "privacy.clearOnShutdown.cookies" = false;
            "privacy.clearOnShutdown.history" = false;
            "network.cookie.lifetimePolicy" = 0;

            # Browsing.
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "browser.search.suggest.enabled" = true;
            "browser.search.suggest.enabled.private" = true;
            "browser.urlbar.suggest.searches" = true;
            "browser.urlbar.showSearchSuggestionsFirst" =true;
            "browser.formfill.enable" = true;
            "browser.topsites.contile.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.snippets" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = true;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = true;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited" = true;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.system.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

            # Extensions.
            "extensions.pocket.enabled" = false;
            "extensions.screenshots.disabled" = true;
          };
        };
      };
    };

    # Librewolf declaration.
    # https://nixos.wiki/wiki/Librewolf
    librewolf.enable = false;

    # Thunderbird declaration.
    # https://wiki.nixos.org/wiki/Thunderbird
    thunderbird.enable = false;
  };

  environment = {
    etc = {
      "firefox/policies/policies.json".target = "librewolf/policies/policies.json";
    };
  };
}
