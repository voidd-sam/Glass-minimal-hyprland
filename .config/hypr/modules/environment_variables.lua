-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

local M = {}
M.terminal = "kitty"
M.fileManager = "kitty -e yazi"
return M
