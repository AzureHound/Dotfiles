{ config, ... }:

{
  editorconfig = {
    inherit (config.pixel.profiles.development) enable;

    settings = {
      "*" = {
        indent_style = "space";
        indent_size = 2;
        tab_width = 4;
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = false;
      };

      "*.{diff,patch,lock}" = {
        indent_size = "unset";
        end_of_line = "unset";
        trim_trailing_whitespace = "unset";
        insert_final_newline = "unset";
      };
    };
  };
}
