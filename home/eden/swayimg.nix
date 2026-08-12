{ pkgs, config, ... }:

{
  programs.swayimg = {
    enable = config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux;

    initLua = ''
      ---@diagnostic disable: undefined-global

      swayimg.imagelist.adjacent = true

      swayimg.viewer.set_window_background(0xff24273a)
      swayimg.viewer.set_image_background(0xff24273a)
      swayimg.viewer.loop = false

      swayimg.slideshow.set_window_background(0xff24273a)
      swayimg.slideshow.set_image_background(0xff24273a)

      swayimg.gallery.thumb_size = 300
      swayimg.gallery.window_color = 0xff24273a
      swayimg.gallery.border_color = 0xffb7bdf8
      swayimg.gallery.unselected_color = 0xff24273a

      swayimg.text.visible = false

      swayimg.viewer.on_key("q", function() swayimg.exit() end)
      swayimg.gallery.on_key("q", function() swayimg.exit() end)

      -- Viewer navigation
      swayimg.viewer.on_key("Right", function() swayimg.viewer.open("next") end)
      swayimg.viewer.on_key("Left",  function() swayimg.viewer.open("prev") end)
      swayimg.viewer.on_key("Up",    function() swayimg.viewer.open("prev") end)
      swayimg.viewer.on_key("Down",  function() swayimg.viewer.open("next") end)

      swayimg.viewer.on_key("l", function() swayimg.viewer.open("next") end)
      swayimg.viewer.on_key("h", function() swayimg.viewer.open("prev") end)
      swayimg.viewer.on_key("k", function() swayimg.viewer.open("prev") end)
      swayimg.viewer.on_key("j", function() swayimg.viewer.open("next") end)

      -- Gallery navigation
      swayimg.gallery.on_key("l", function() swayimg.gallery.select("right") end)
      swayimg.gallery.on_key("h", function() swayimg.gallery.select("left") end)
      swayimg.gallery.on_key("k", function() swayimg.gallery.select("up") end)
      swayimg.gallery.on_key("j", function() swayimg.gallery.select("down") end)
    '';
  };
}
