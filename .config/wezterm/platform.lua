local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

function M.common(config)
    config.color_scheme = "Gruvbox dark, medium (base16)"

    config.inactive_pane_hsb = {
        saturation = 1,
        brightness = 1,
    }

    config.max_fps = 144
    config.animation_fps = 144
    config.front_end = "WebGpu"
    config.webgpu_power_preference = "HighPerformance"

    config.check_for_updates = true
    config.window_close_confirmation = "NeverPrompt"

    config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    }

    config.tab_bar_at_bottom = true
    config.tab_and_split_indices_are_zero_based = true
    config.tab_max_width = 8

    config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
    config.keys = {
        {
            key = "Tab",
            mods = "CTRL",
            action = act.DisableDefaultAssignment,
        },
        {
            key = "Tab",
            mods = "CTRL|SHIFT",
            action = act.DisableDefaultAssignment,
        },
        {
            key = "a",
            mods = "LEADER|CTRL",
            action = act.SendKey({ key = "a", mods = "CTRL" }),
        },
        {
            key = "c",
            mods = "LEADER",
            action = act.SpawnTab("CurrentPaneDomain"),
        },
        {
            key = "-",
            mods = "LEADER",
            action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "|",
            mods = "LEADER|SHIFT",
            action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "p",
            mods = "LEADER",
            action = act.ActivateTabRelative(-1),
        },
        {
            key = "n",
            mods = "LEADER",
            action = act.ActivateTabRelative(1),
        },
        {
            key = "l",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Right"),
        },
        {
            key = "h",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Left"),
        },
        {
            key = "k",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Up"),
        },
        {
            key = "j",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Down"),
        },
    }

    for i = 0, 7 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = "LEADER",
            action = act.ActivateTab(i),
        })
    end
end

function M.windows(config)
    config.font = wezterm.font("Noto Sans Mono")
    config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    config.font_size = 13.0
    config.default_prog = { "pwsh.exe", "-NoLogo", "-noexit" }
end

function M.linux(_)
    -- TODO: Configure target dependent settings(linux)
end

return M
