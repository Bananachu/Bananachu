{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Variables
      "$terminal" = "kitty";
      "$fileManager" = "kitty -T ranger -e ranger";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      # Moniteurs
      monitor = [
        "LVDS-1, 1600x900@60, 0x0, 1"
        "VGA-1,disable"
      ];

      # Autostart
      exec-once = [
        "waybar"
        # Utilisation des simples guillemets ('' '') en Nix pour ne pas casser les guillemets de mpvpaper
        ''mpvpaper HDMI-A-1 -o "loop" -f ~/Images/wallpapers/zeldaww2.mp4 --auto-pause''
      ];

      # Variables d'environnement
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # Permissions / Ecosystem
      ecosystem = {
        no_update_news = true;
      };

      # Apparence générale
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(88c0d0ff)";
        "col.inactive_border" = "rgba(2e3440ff)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Décoration
      decoration = {
        rounding = 0;
        rounding_power = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true; # Remplace le "yes, please :)"
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Layouts
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };

      # Divers
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # Entrées (Clavier/Souris)
      input = {
        kb_layout = "fr";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0.5;
        numlock_by_default = true;
        touchpad = {
          natural_scroll = false;
        };
      };

      # Configuration d'un appareil spécifique
      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      # Raccourcis classiques et souris
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod SHIFT, A, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, E, exec, [floating] $fileManager"
        "$mainMod, F, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, G, exec, chromium --profile-directory=Default --app-id=caidcmannjgahlnbpmidmiecjcoiiigg --class=webapp"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        # Déplacement du focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Changement de bureaux (Azerty)
        "$mainMod, ampersand, workspace, 1"
        "$mainMod, eacute, workspace, 2"
        "$mainMod, quotedbl, workspace, 3"
        "$mainMod, apostrophe, workspace, 4"
        "$mainMod, parenleft, workspace, 5"
        "$mainMod, minus, workspace, 6"
        "$mainMod, egrave, workspace, 7"
        "$mainMod, underscore, workspace, 8"
        "$mainMod, ccedilla, workspace, 9"
        "$mainMod, agrave, workspace, 10"

        # Déplacer silencieusement une fenêtre vers un bureau
        "$mainMod SHIFT, ampersand, movetoworkspacesilent, 1"
        "$mainMod SHIFT, eacute, movetoworkspacesilent, 2"
        "$mainMod SHIFT, quotedbl, movetoworkspacesilent, 3"
        "$mainMod SHIFT, apostrophe, movetoworkspacesilent, 4"
        "$mainMod SHIFT, parenleft, movetoworkspacesilent, 5"
        "$mainMod SHIFT, minus, movetoworkspacesilent, 6"
        "$mainMod SHIFT, egrave, movetoworkspacesilent, 7"
        "$mainMod SHIFT, underscore, movetoworkspacesilent, 8"
        "$mainMod SHIFT, ccedilla, movetoworkspacesilent, 9"
        "$mainMod SHIFT, agrave, movetoworkspacesilent, 10"

        # Bureau spécial (Magic)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Molette de la souris pour les bureaux
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Mouvements de souris (Boutons cliqués)
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Raccourcis multimédia (Répétables = bindel)
      bindel = [
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ];

      # Raccourcis multimédia (Appui simple = bindl)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Règles de fenêtres corrigées pour la syntaxe officielle V2
      windowrule = [
        "float on, match:title ranger"
        #"float, title:^(alsamixer)$"
        #"float, title:^(nmcli)$"
        #"tile, class:^(webapp)$"
      ];
    };
  };
}
