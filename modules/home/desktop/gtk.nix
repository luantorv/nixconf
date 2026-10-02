# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

let
  colors = config.colors;

  surface       = "#1e1d1b";
  surfaceRaised = "#232220";
  surfaceHover  = "#2d2b28";

  border = "alpha(${colors.grey}, 0.35)";
  borderStrong = "alpha(${colors.grey}, 0.55)";

  gtk3 = pkgs.writeTextDir
    "share/themes/Verdigris/gtk-3.0/gtk.css"
    ''
      /*
       * Verdigris GTK Theme
       * GTK 3
       */

      @define-color theme_fg_color           ${colors.white};
      @define-color theme_text_color         ${colors.white};
      @define-color theme_bg_color           ${colors.black};

      @define-color theme_base_color         ${colors.black};
      @define-color theme_selected_bg_color  ${colors.lightblue};
      @define-color theme_selected_fg_color  ${colors.black};

      @define-color insensitive_fg_color     ${colors.grey};

      @define-color borders                  ${border};
      @define-color borders_strong           ${borderStrong};

      @define-color surface                  ${surface};
      @define-color surface_raised           ${surfaceRaised};
      @define-color surface_hover            ${surfaceHover};

      @define-color accent                   ${colors.lavanda};
      @define-color accent_hover             ${colors.darkblue};

      @define-color link                     ${colors.darkblue};
      @define-color success                  ${colors.lightblue};
      @define-color warning                  ${colors.sand};
      @define-color error                    ${colors.red};


      /* Base */

      * {
        -GtkWidget-focus-padding: 0;
        -GtkWidget-focus-line-width: 1;
        -GtkWidget-link-color: @link;
        -GtkWidget-visited-link-color: @accent;
        -GtkWidget-focus-line-width: 1;

        color: @theme_fg_color;
      }

      window,
      dialog,
      .background {
        background-color: @theme_bg_color;
        color: @theme_fg_color;
      }

      /* Text */

      label {
        color: @theme_fg_color;
      }

      label:disabled {
        color: @insensitive_fg_color;
      }

      entry,
      textview,
      spinbutton,
      .view,
      treeview {
        color: @theme_text_color;
        background-color: @theme_base_color;
        caret-color: @accent;
      }

      entry:focus,
      spinbutton:focus {
        border-color: @accent;
        box-shadow: inset 0 0 0 1px @accent;
      }

      entry selection,
      textview selection,
      treeview.view:selected {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
      }

      /* Buttons */

      button {
        color: @theme_fg_color;
        background-color: @surface_raised;

        border: 1px solid @borders;
        border-radius: 6px;

        padding: 5px 10px;

        box-shadow: none;
      }

      button:hover {
        background-color: @surface_hover;
        border-color: @accent;
      }

      button:active,
      button:checked {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
        border-color: @theme_selected_bg_color;
      }

      button:disabled {
        color: @insensitive_fg_color;
        background-color: @surface;
        border-color: @borders;
      }

      button.suggested-action {
        background-color: @accent;
        color: @theme_selected_fg_color;
        border-color: @accent;
      }

      button.suggested-action:hover {
        background-color: @accent_hover;
        color: @theme_fg_color;
      }

      button.destructive-action {
        background-color: @error;
        color: @theme_selected_fg_color;
      }

      /* Headerbars / toolbars */

      headerbar,
      .titlebar {
        color: @theme_fg_color;
        background-color: @theme_bg_color;

        border-bottom: 1px solid @borders;

        box-shadow: none;
      }

      headerbar button,
      .titlebar button {
        background-color: transparent;
        border-color: transparent;
      }

      headerbar button:hover,
      .titlebar button:hover {
        background-color: @surface_hover;
        border-color: @borders;
      }

      /* Menus */

      menu,
      menuitem {
        color: @theme_fg_color;
        background-color: @theme_bg_color;
      }

      menuitem:hover {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
      }

      /* Popovers */

      popover,
      popover.background {
        color: @theme_fg_color;
        background-color: @theme_bg_color;

        border: 1px solid @borders;
        border-radius: 8px;

        box-shadow:
          0 4px 16px alpha(#000000, 0.35);
      }

      /* Tooltips */

      tooltip,
      tooltip.background {
        color: @theme_fg_color;
        background-color: @theme_bg_color;

        border: 1px solid @borders;
        border-radius: 6px;
      }

      /* Selection / focus */

      :focus {
        outline-color: @accent;
      }

      *:focus {
        -gtk-outline-color: @accent;
      }

      /* Check buttons / radio buttons */

      checkbutton check,
      radiobutton radio {
        background-color: @surface_raised;
        border: 1px solid @borders_strong;
      }

      checkbutton check:checked,
      radiobutton radio:checked {
        background-color: @accent;
        border-color: @accent;
        color: @theme_selected_fg_color;
      }

      /* Switches */

      switch {
        background-color: @surface_raised;
        border: 1px solid @borders_strong;
      }

      switch:checked {
        background-color: @success;
        border-color: @success;
      }

      switch slider {
        background-color: @theme_fg_color;
      }

      /* Scale / sliders */

      scale trough {
        background-color: @surface_raised;
        border: 1px solid @borders;
      }

      scale highlight {
        background-color: @accent;
      }

      scale slider {
        background-color: @theme_fg_color;
        border: 1px solid @borders_strong;
      }

      /* Progress bars */

      progressbar trough {
        background-color: @surface_raised;
      }

      progressbar progress {
        background-color: @success;
      }

      /* Scrollbars */

      scrollbar trough {
        background-color: transparent;
      }

      scrollbar slider {
        background-color: alpha(@grey, 0.55);
        border-radius: 999px;
      }

      scrollbar slider:hover {
        background-color: @accent;
      }

      /* Links */

      link {
        color: @link;
      }

      link:hover {
        color: @accent;
      }

      /* Notifications / status */

      .success {
        color: @success;
      }

      .warning {
        color: @warning;
      }

      .error {
        color: @error;
      }

      /* File chooser */

      filechooser,
      filechooser .view {
        background-color: @theme_base_color;
        color: @theme_fg_color;
      }

      filechooser .view:selected {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
      }
    '';

  gtk3-dark = pkgs.writeTextDir
    "share/themes/Verdigris/gtk-3.0/gtk-dark.css"
    ''
      @import url("gtk.css");
    '';


  gtk4 = pkgs.writeTextDir
    "share/themes/Verdigris/gtk-4.0/gtk.css"
    ''
      /*
       * Verdigris GTK Theme
       * GTK 4
       */

      @define-color theme_fg_color           ${colors.white};
      @define-color theme_text_color         ${colors.white};
      @define-color theme_bg_color           ${colors.black};

      @define-color theme_base_color         ${colors.black};
      @define-color theme_selected_bg_color  ${colors.lightblue};
      @define-color theme_selected_fg_color  ${colors.black};

      @define-color insensitive_fg_color     ${colors.grey};

      @define-color borders                  ${border};
      @define-color borders_strong           ${borderStrong};

      @define-color surface                  ${surface};
      @define-color surface_raised           ${surfaceRaised};
      @define-color surface_hover            ${surfaceHover};

      @define-color accent                   ${colors.lavanda};
      @define-color accent_hover             ${colors.darkblue};

      @define-color link                     ${colors.darkblue};
      @define-color success                  ${colors.lightblue};
      @define-color warning                  ${colors.sand};
      @define-color error                    ${colors.red};


      /* Base */

      window {
        background-color: @theme_bg_color;
        color: @theme_fg_color;
      }

      .background {
        background-color: @theme_bg_color;
        color: @theme_fg_color;
      }

      label {
        color: @theme_fg_color;
      }

      /* Buttons */

      button {
        color: @theme_fg_color;
        background-color: @surface_raised;

        border: 1px solid @borders;
        border-radius: 6px;

        box-shadow: none;
      }

      button:hover {
        background-color: @surface_hover;
        border-color: @accent;
      }

      button:active,
      button:checked {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
        border-color: @theme_selected_bg_color;
      }

      button:disabled {
        color: @insensitive_fg_color;
        background-color: @surface;
      }

      button.suggested-action {
        background-color: @accent;
        color: @theme_selected_fg_color;
        border-color: @accent;
      }

      button.destructive-action {
        background-color: @error;
        color: @theme_selected_fg_color;
      }

      /* Entries */

      entry,
      spinbutton {
        color: @theme_text_color;
        background-color: @theme_base_color;
        caret-color: @accent;

        border: 1px solid @borders;
        border-radius: 6px;
      }

      entry:focus,
      spinbutton:focus {
        border-color: @accent;
      }

      /* Text selection */

      selection {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
      }

      /* Headerbar */

      headerbar {
        color: @theme_fg_color;
        background-color: @theme_bg_color;

        border-bottom: 1px solid @borders;
        box-shadow: none;
      }

      /* Menus */

      popover,
      menu {
        color: @theme_fg_color;
        background-color: @theme_bg_color;

        border: 1px solid @borders;
      }

      /* Check / radio */

      checkbutton check,
      radiobutton radio {
        background-color: @surface_raised;
        border: 1px solid @borders_strong;
      }

      checkbutton check:checked,
      radiobutton radio:checked {
        background-color: @accent;
        border-color: @accent;
        color: @theme_selected_fg_color;
      }

      /* Switches */

      switch {
        background-color: @surface_raised;
        border: 1px solid @borders_strong;
      }

      switch:checked {
        background-color: @success;
        border-color: @success;
      }

      switch slider {
        background-color: @theme_fg_color;
      }

      /* Sliders */

      scale trough {
        background-color: @surface_raised;
      }

      scale highlight {
        background-color: @accent;
      }

      scale slider {
        background-color: @theme_fg_color;
        border: 1px solid @borders_strong;
      }

      /* Progress */

      progressbar trough {
        background-color: @surface_raised;
      }

      progressbar progress {
        background-color: @success;
      }

      /* Scrollbars */

      scrollbar slider {
        background-color: alpha(@theme_fg_color, 0.35);
        border-radius: 999px;
      }

      scrollbar slider:hover {
        background-color: @accent;
      }

      /* Links */

      link {
        color: @link;
      }

      link:hover {
        color: @accent;
      }

      /* Tooltips */

      tooltip {
        color: @theme_fg_color;
        background-color: @theme_bg_color;

        border: 1px solid @borders;
        border-radius: 6px;
      }
    '';

  gtk4-dark = pkgs.writeTextDir
    "share/themes/Verdigris/gtk-4.0/gtk-dark.css"
    ''
      @import url("gtk.css");
    '';

  verdigrisTheme = pkgs.symlinkJoin {
    name = "verdigris-gtk-theme";

    paths = [
      gtk3
      gtk3-dark
      gtk4
      gtk4-dark
    ];
  };

in
{
  gtk = {
    enable = true;

    colorScheme = "dark";

    theme = {
      name = "Verdigris";
      package = verdigrisTheme;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    gtk3 = {
      enable = true;

      colorScheme = "dark";

      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-enable-primary-paste = true;
      };
    };

    gtk4 = {
      enable = true;

      colorScheme = "dark";

      # GTK 4 theming is explicitly opt-in in recent Home Manager versions.
      theme = {
        name = "Verdigris";
        package = verdigrisTheme;
      };
    };
  };
}