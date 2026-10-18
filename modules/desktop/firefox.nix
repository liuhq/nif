{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.desktop;
in
{
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-US"
        "zh-CN"
        "ja"
      ];
      policies = {
        AIControls.Default = {
          Value = "blocked";
          Locked = true;
        };
        DefaultBrowserSettingEnabled = false;
        ## TODO: managing bookmarks and autofills
        DisableAccounts = true;
        DisableFeedbackCommands = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableMasterPasswordCreation = true;
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        DisableRemoteImprovements = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        DisplayMenuBar = "default-off";
        DNSOverHTTPS = {
          Enabled = false;
          Locked = true;
        };
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Category = "standard";
          BaselineExceptions = true;
          ConvenienceExceptions = true;
        };
        EncryptedMediaExtensions = {
          Enabled = true;
          Locked = true;
        };
        Extensions = {
          Install = [
            "https://addons.mozilla.org/firefox/downloads/file/5070529/nord_firefox-3.0.xpi"
          ];
        };
        FirefoxHome = {
          Locked = true;
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Stories = false;
          SponsoredStories = false;
          Weather = false;
          Widgets.Enabled = false;
        };
        GoToIntranetSiteForSingleWordEntryInAddressBar = false;
        Homepage = {
          Locked = true;
          URL = "about:home";
          StartPage = "homepage";
        };
        IPProtectionAvailable = false;
        NewTabPage = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        PasswordManagerEnabled = false;
        PDFjs.Enabled = false;
        PictureInPicture = {
          Enabled = true;
          Locked = true;
        };
        PromptForDownloadLocation = true;
        RequestedLocales = [
          "en-US"
          "zh-CN"
          "ja"
        ];
        SearchBar = "unified";
        ## https://firefox-admin-docs.mozilla.org/reference/policies/searchengines/
        SearchEngines = {
          Remove = [
            "Bing"
            "DuckDuckGo"
            "Perplexity"
          ];
        };
        SearchSuggestEnabled = false;
        ShowHomeButton = false;
        SkipTermsOfUse = true;
        UserMessaging = {
          Locked = true;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = false;
        };
      };
      preferences = {
        "browser.active_color" = "#BF616A";
        "browser.active_color.dark" = "#BF616A";
        "browser.anchor_color" = "#81A1C1";
        "browser.anchor_color.dark" = "#8FBCBB";
        "browser.display.background_color" = "#F2F4F8";
        "browser.display.background_color.dark" = "#242933";
        "browser.display.foreground_color" = "#2E3440";
        "browser.display.foreground_color.dark" = "#ECEFF4";
        "browser.theme.toolbar-theme" = 0;
        "browser.theme.content-theme" = 0;
        "browser.uidensity" = 1;
        "browser.visited_color" = "#B48EAD";
        "browser.visited_color.dark" = "#B48EAD";
        "dom.compression_streams.zstd.enabled" = true;
        ## https://addons.mozilla.org/en-US/firefox/addon/nord-firefox/
        "extensions.activeThemeID" = "{f4c9e1d6-6630-4600-ad50-d223eab7f3e7}";
        "privacy.globalprivacycontrol.enabled" = true;
        "media.autoplay.default" = 5;
        "sidebar.visibility" = "hide-on-close";
      };
    };
  };
}
