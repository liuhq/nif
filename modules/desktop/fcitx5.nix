{
  config,
  pkgs,
  lib,
  paths,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (paths) external;
  mkAttrTrue = lst: lib.genAttrs lst (n: "True");
  mkAttrFalse = lst: lib.genAttrs lst (n: "False");
in
{
  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-mozc

        fcitx5-gtk
        fcitx5-nord

        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];

      fcitx5.waylandFrontend = true;

      # fcitx5.ignoreUserConfig = true;

      fcitx5.quickPhraseFiles = {
        QuickPhrase = "${external}/fcitx5/QuickPhrase.mb";
      };

      fcitx5.settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "keyboard-us";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "pinyin";
        "Groups/0/Items/2".Name = "mozc";
      };

      fcitx5.settings.globalOptions = {
        Hotkey = {
          EnumerateWithTriggerKeys = "True";
          EnumerateSkipFirst = "False";
          ModifierOnlyKeyTimeout = 250;
        };

        "Hotkey/TriggerKeys"."0" = "Super+space";
        "Hotkey/PrevPage"."0" = "Control+P";
        "Hotkey/NextPage"."0" = "Control+N";
        "Hotkey/PrevCandidate"."0" = "Control+K";
        "Hotkey/NextCandidate"."0" = "Control+J";

        Behavior = {
          DefaultPageSize = 7;
          AutoSavePeriod = 30;
        }
        // mkAttrTrue [
          "ShowInputMethodInformation"
          "CompactInputMethodInformation"
          "ShowFirstInputMethodInformation"
          "PreloadInputMethod"
        ]
        // mkAttrFalse [
          "ActiveByDefault"
          "resetStateWhenFocusIn"
          "ShareInputState"
          "PreeditEnabledByDefault"
          "showInputMethodInformationWhenFocusIn"
          "OverrideXkbOption"
          "AllowInputMethodForPassword"
          "ShowPreeditForPassword"
        ];
      };

      fcitx5.settings.addons = {
        pinyin = {
          globalSection = {
            PageSize = 7;
            CloudPinyinIndex = 2;
            PreeditMode = "Composing pinyin";
            PredictionSize = 49;
            BackspaceBehaviorOnPrediction = "Backspace when not using on-screen keyboard";
            SwitchInputMethodBehavior = "Clear";
            "Number of sentence" = 2;
            WordCandidateLimit = 15;
            LongWordLengthLimit = 4;
          }
          // mkAttrTrue [
            "EmojiEnabled"
            "SpellEnabled"
            "SymbolsEnabled"
            "ChaiziEnabled"
            "ExtBEnabled"
            "StrokeCandidateEnabled"
            "CloudPinyinEnabled"
            "PinyinInPreedit"
            "KeepCurrentContext"
            "BackSpaceToUnselect"
            "VAsQuickphrase"
          ]
          // mkAttrFalse [
            "CloudPinyinAnimation"
            "KeepCloudPinyinPlaceHolder"
            "PreeditCursorPositionAtBeginning"
            "Prediction"
            "UseKeypadAsSelection"
            "FirstRun"
          ];

          sections = {
            ForgetWord."0" = "Control+7";
            "PrevPage"."0" = "Control+P";
            "NextPage"."0" = "Control+N";
            "PrevCandidate"."0" = "Control+K";
            "NextCandidate"."0" = "Control+J";
            "CurrentCandidate"."0" = "space";
            "CommitRawInput"."0" = "Return";
            "ChooseCharFromPhrase"."0" = "Control+F";
            "ChooseCharFromPhrase"."1" = "Control+B";
            "FilterByStroke"."0" = "grave";
            "QuickPhraseTriggerRegex"."0" = ".(/|@)$";
            "QuickPhraseTriggerRegex"."1" = "^(www|bbs|forum|mail|bbs)\\.";
            "QuickPhraseTriggerRegex"."2" = "^(http|https|ftp|telnet|mailto):";

            Fuzzy = {
              Correction = "None";
            }
            // mkAttrTrue [
              "VE_UE"
            ]
            // mkAttrFalse [
              "NG_GN"
              "Inner"
              "InnerShort"
              "PartialFinal"
              "PartialSp"
              "V_U"
              "AN_ANG"
              "EN_ENG"
              "IAN_IANG"
              "IN_ING"
              "U_OU"
              "UAN_UANG"
              "C_CH"
              "F_H"
              "L_N"
              "L_R"
              "S_SH"
              "Z_ZH"
            ];
          };
        };
      };
    };
  };
}
