local wezterm = require("wezterm")
local platform = require("platform")

local config = {}

platform.common(config)

local target = wezterm.target_triple

local is_target_windows = function()
	return target == "x86_64-pc-windows-msvc"
end

local is_target_linux = function()
	return target == "x86_64-unknown-linux-gnu"
end

if is_target_windows() then
	platform.windows(config)
elseif is_target_linux() then
	platform.linux(config)
end

return config
