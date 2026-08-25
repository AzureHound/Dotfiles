{
  lib,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (config.pixel.profiles.graphical.enable && config.programs.kitty.enable) {
    programs.kitty = {
      shellIntegration.mode = "no-cursor";

      settings = {
        font_family = "family='JetBrainsMono Nerd Font' style=Regular";
        bold_font = "family='JetBrainsMono Nerd Font' style=SemiBold";
        italic_font = "family='JetBrainsMono Nerd Font' style=Italic";
        bold_italic_font = "family='JetBrainsMono Nerd Font' style='SemiBold Italic'";
        font_size = "12.9";
        modify_font = "cell_height 116%";

        cursor_shape = "beam";
        cursor_beam_thickness = 2;
        cursor_blink_interval = "-1 ease-in-out";

        cursor_trail = 1;
        cursor_trail_decay = "0.1 0.4";
        cursor_trail_start_threshold = 4;

        scrollback_lines = 10000;
        scrollback_pager_history_size = 100;
        # scrollback_fill_enlarged_window = "yes";

        paste_actions = "quote-urls-at-prompt,confirm-if-large";
        strip_trailing_spaces = "smart";

        remember_window_size = "no";
        window_border_width = "1pt";
        window_padding_width = 6;
        inactive_text_alpha = "0.84";
        hide_window_decorations = "yes";
        # window_logo_path = "./kitty.app.png";
        confirm_os_window_close = 0;

        tab_bar_style = "powerline";
        tab_separator = " |";
        tab_powerline_style = "slanted";
        # tab_powerline_style = "angled";
        tab_title_template = "{f'{title[:30]}…' if title.rindex(title[-1]) + 1 > 30 else (title.center(6) if (title.rindex(title[-1]) + 1) % 2 == 0 else title.center(5))}";

        # background_opacity = 0.94;
        # background_blur = 20;
        # dynamic_background_opacity = "yes";
        # background_image = "~/Developer/Wallpapers/windows.png";
        # background_image_layout = "centered";
        # background_tint = 0.9;
        # dim_opacity = 0.4;

        shell = "${pkgs.zsh}/bin/zsh";
        editor = config.pixel.programs.defaults.editor;
        # close_on_child_death = "yes";
        allow_remote_control = "yes";
        listen_on = "unix:@mykitty";
        notify_on_cmd_finish = "unfocused";

        kitty_mod = "ctrl+shift";
      };

      keybindings = {
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";

        "kitty_mod+up" = "scroll_line_up";
        "kitty_mod+down" = "scroll_line_down";
        "kitty_mod+k" = "scroll_page_up";
        "kitty_mod+j" = "scroll_page_down";
        "kitty_mod+home" = "scroll_home";
        "kitty_mod+end" = "scroll_end";

        # "kitty_mod+x" = "scroll_to_prompt -1";

        "kitty_mod+enter" = "new_window";
        "kitty_mod+w" = "close_window";

        "kitty_mod+[" = "next_window";
        "kitty_mod+]" = "previous_window";

        "kitty_mod+f" = "move_window_forward";
        "kitty_mod+b" = "move_window_backward";

        "kitty_mod+right" = "next_tab";
        "kitty_mod+." = "next_tab";
        "ctrl+tab" = "next_tab";

        "kitty_mod+left" = "previous_tab";
        "kitty_mod+," = "previous_tab";
        "ctrl+shift+tab" = "previous_tab";

        "kitty_mod+return" = "new_tab";
        "kitty_mod+t" = "new_tab";
        "kitty_mod+q" = "close_tab";

        "kitty_mod+r" = "set_tab_title";

        "kitty_mod+1" = "goto_tab 1";
        "kitty_mod+2" = "goto_tab 2";
        "kitty_mod+3" = "goto_tab 3";
        "kitty_mod+4" = "goto_tab 4";
        "kitty_mod+5" = "goto_tab 5";
        "kitty_mod+6" = "goto_tab 6";
        "kitty_mod+7" = "goto_tab 7";
        "kitty_mod+8" = "goto_tab 8";
        "kitty_mod+9" = "goto_tab 9";
        "kitty_mod+0" = "goto_tab 10";

        "kitty_mod+\\" = "launch --cwd=current";
        "kitty_mod+l" = "next_layout";
        "kitty_mod+i" = "goto_layout tall";
        "kitty_mod+o" = "goto_layout stack";
        "kitty_mod+s" = "toggle_layout stack";

        "kitty_mod+equal" = "change_font_size all +1.0";
        "kitty_mod+plus" = "change_font_size all +1.0";
        "kitty_mod+kp_add" = "change_font_size all +1.0";

        "kitty_mod+minus" = "change_font_size all -1.0";
        "kitty_mod+kp_subtract" = "change_font_size all -1.0";

        "kitty_mod+backspace" = "change_font_size all 0";

        "kitty_mod+h" = "kitty_scrollback_nvim";
        "kitty_mod+g" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";

        "kitty_mod+p" =
          "launch --type=background --cwd=current sh -c 'swaymsg exec \"xdg-open .\"; swaymsg \"[con_id=\\\"$KITTY_WINDOW_ID\\\"] floating enable, move position center, resize set 60ppt 60ppt\"'";
        "kitty_mod+/" =
          "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
        "kitty_mod+x" = "launch --type=background --cwd=current sh -c 'zeditor $(pwd)'";
        "kitty_mod+y" = "launch --type=overlay-main --cwd=current yazi";

        "kitty_mod+u" = "kitten unicode_input";
        "kitty_mod+e" = "open_url_with_hints";

        "kitty_mod+!" = "load_config_file";
      };

      extraConfig = ''
        action_alias kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py
        mouse_map kitty_mod+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
      '';

      quickAccessTerminalConfig = {
        # background_opacity = 0.90;
        hide_on_focus_loss = true;
      };

      diffConfig = {
        settings = {
          color_scheme = "dark";
        };

        extraConfig = ''
          include themes/diff-macchiato.conf
        '';

        keybindings = {
          "q" = "quit";
          "esc" = "quit";
          "j" = "scroll_by 1";
          "down" = "scroll_by 1";
          "k" = "scroll_by -1";
          "up" = "scroll_by -1";
          "home" = "scroll_to start";
          "end" = "scroll_to end";
          "page_down" = "scroll_to next-page";
          "space" = "scroll_to next-page";
          "ctrl+f" = "scroll_to next-page";
          "page_up" = "scroll_to prev-page";
          "ctrl+b" = "scroll_to prev-page";
          "ctrl+d" = "scroll_to next-half-page";
          "ctrl+u" = "scroll_to prev-half-page";
          "n" = "scroll_to next-change";
          "p" = "scroll_to prev-change";
          "shift+j" = "scroll_to next-file";
          "shift+k" = "scroll_to prev-file";
          "a" = "change_context all";
          "=" = "change_context default";
          "+" = "change_context 5";
          "-" = "change_context -5";
          "/" = "start_search regex forward";
          "?" = "start_search regex backward";
          "." = "scroll_to next-match";
          ">" = "scroll_to next-match";
          "," = "scroll_to prev-match";
          "<" = "scroll_to prev-match";
          "f" = "start_search substring forward";
          "b" = "start_search substring backward";
          "y" = "copy_to_clipboard";
          "ctrl+c" = "copy_to_clipboard_or_exit";
        };
      };
    };

    xdg.configFile = mkCfgLink (
      map (f: "kitty/${f}") [
        "kitty-open-helper.sh"
        "kitty.app.icns"
        "neighboring_window.py"
        "open-actions.conf"
        "pass_keys.py"
        "relative_resize.py"
        "scroll_mark.py"
        "search.py"
        "ssh.conf"
        "tab_bar.py"

        "themes"
      ]
    );
  };
}
