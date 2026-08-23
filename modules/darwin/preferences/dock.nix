{ name, ... }:

let
  cryptexApps = builtins.map (app: "/System/Cryptexes/App/System/Applications/${app}");
  systemApps = builtins.map (app: "/System/Applications/${app}");
  hmApps = builtins.map (app: "/Users/${name}/Applications/Home Manager Apps/${app}");
in

{
  system.defaults = {
    dock = {
      tilesize = 48;
      magnification = true;
      largesize = 70;

      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 1.0;

      show-recents = false;
      showhidden = true;
      static-only = false;

      # launchanim = false;
      mineffect = "scale";
      minimize-to-application = true;

      expose-group-apps = true;
      appswitcher-all-displays = true;
      mru-spaces = false; # Recent spaces

      mouse-over-hilite-stack = true;
      enable-spring-load-actions-on-all-items = true;

      # Hot Corners
      #  1: Disabled
      #  2: Mission Control
      #  3: Application Windows
      #  4: Desktop
      #  5: Start Screen Saver
      #  6: Disable Screen Saver
      #  7: Dashboard
      #  10: Put Display to Sleep
      #  11: Launchpad
      #  12: Notification Center
      #  13: Lock Screen
      #  14: Quick Note
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 14;

      persistent-apps =
        [ ]
        ++ cryptexApps [ "Safari.app" ]
        ++ systemApps [
          "Messages.app"
          "Mail.app"
          # "Maps.app"
          "Photos.app"
          "FaceTime.app"
          "Calendar.app"
          # "Contacts.app"
          "Reminders.app"
          "Notes.app"
          "Freeform.app"
          # "TV.app"
          "Music.app"
          # "App Store.app"
          # "System Settings.app"
        ]
      # ++ hmApps [ "Zen Browser (Beta).app" ]
      ;

      persistent-others = [
        {
          folder = {
            path = "/Users/${name}/Downloads";
            displayas = "folder";
            showas = "fan";
          };
        }
      ];
    };
  };
}
