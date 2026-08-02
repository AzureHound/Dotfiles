hl.config({
  plugin = {
    csgo_vulkan_fix = {
      fix_mouse = true,
    },
  },
})

hl.plugin.csgo_vulkan_fix.vkfix_app({ app = "cs2", w = 1920, h = 1080 })
