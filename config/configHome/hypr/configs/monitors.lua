-- █▀▄▀█ █▀█ █▄ █ █ ▀█▀ █▀█ █▀█ █▀
-- █ ▀ █ █▄█ █ ▀█ █  █  █▄█ █▀▄ ▄█

---@diagnostic disable: undefined-global
for _, m in ipairs(monitors) do
  hl.monitor({
    output = m.output,
    mode = m.mode,
    position = m.position,
    scale = m.scale,
  })
end

-- PERF: Don't run on single monitor
if #monitors > 1 then
  local per_mon = math.floor(10 / #monitors)
  for ws = 1, 10 do
    local idx = math.min(math.floor((ws - 1) / per_mon), #monitors - 1)
    hl.workspace_rule({
      workspace = tostring(ws),
      monitor = monitors[idx + 1].output,
      default = ws == 1 or nil,
    })
  end
end

-- hl.monitor({
--   output = "DP-1",
--   mode = "2560x1440@119.99800",
--   position = "0x0",
--   scale = 1.33333,
--   bitdepth = 8,
--   cm = "auto",
-- })

-- hl.monitor({
--   output = "DP-1",
--   mode = "2560x1440@119.99800",
--   position = "0x0",
--   scale = 1.33333,
--   bitdepth = 10,
--   cm = "hdr",
--   sdrbrightness = 1.4,
--   sdrsaturation = 1.4
-- })
