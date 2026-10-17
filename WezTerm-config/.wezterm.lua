-----------------------------------------------------------------------
---------- Init
-----------------------------------------------------------------------

local wezterm = require 'wezterm'
local config = wezterm.config_builder()



-----------------------------------------------------------------------
---------- Environment
-----------------------------------------------------------------------

-- Default domain (terminal)
--config.default_domain = 'WSL:Ubuntu'



-----------------------------------------------------------------------
---------- Color and Appearance
-----------------------------------------------------------------------

-- Font
config.font_size = 12

-- The panes that are there visible, but don't currently active.
config.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.7,
}

-- Background image
--config.window_background_image = '/absolute/path/to/your/chill-guy.png'
config.window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3
  brightness = 0.03,

  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,

  -- You can also adjust the saturation.
  saturation = 1.0,
}

-- Don't merge characters into a single one (example don't merge >= into the mathematical representation)
config.font = wezterm.font {
   family = 'JetBrains Mono',
   harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}

-- The number of lines that WezTerm will remember per pane (15-30 MB of RAM per 10.000 lines).
config.scrollback_lines = 10000



-----------------------------------------------------------------------
---------- Keybindings
-----------------------------------------------------------------------

-----------------------------------
----- Keybinding helper functions
-----------------------------------

-- Helper: split the current pane in the given direction, staying in the same domain (WSL)
local function split_pane(direction)
  return wezterm.action_callback(function(_, pane)
    pane:split({
      direction = direction,
      domain = 'CurrentPaneDomain', -- top-level field, not nested in "command"
    })
  end)
end


-- Helper: Find the array position (1-based) of the currently active tab
-- within its window, alongside the full tabs_with_info() array.
local function get_active_tab_position(window)
  local tabs = window:mux_window():tabs_with_info()
  for i, t in ipairs(tabs) do
    if t.is_active then
      return i, tabs
    end
  end
  return nil, tabs
end


-- Helper: Move/swap the current tab's position left or right, but only if
-- a neighboring tab actually exists in that direction (no wrap-around).
local function move_tab_no_wrap(offset)
  return wezterm.action_callback(function(window, pane)
    local current_pos, tabs = get_active_tab_position(window)
    local target_pos = current_pos and (current_pos + offset) or nil

    if not target_pos or target_pos < 1 or target_pos > #tabs then
      return -- no tab in that direction; do nothing
    end

    -- MoveTab takes a 0-based absolute index
    window:perform_action(wezterm.action.MoveTab(target_pos - 1), pane)
  end)
end



-----------------------------------
----- Keybindings
-----------------------------------

config.keys = {
  -- Smart Ctrl + c: Copy if text is selected, send SIGINT (Ctrl+C) if not, which is the default behaviour
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ''
      if has_selection then
        window:perform_action(wezterm.action.CopyTo 'Clipboard', pane)
      else
        window:perform_action(wezterm.action.SendKey { key = 'c', mods = 'CTRL' }, pane)
      end
    end),
  },

  -- Paste with Ctrl + v
  {
    key = 'v',
    mods = 'CTRL',
    action = wezterm.action.PasteFrom 'Clipboard',
  },

  -- Ctrl + z: Undo last edit
  {
    key = 'z',
    mods = 'CTRL',
    action = wezterm.action.SendString '\x1f',
  },

  -- Ctrl + Shift + z: Suspend the foreground process (the job Ctrl+Z used to do)
  {
    key = 'z',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SendString '\x1a',
  },

  -- Create a new pane in the specified arrow direction using ALT + CTRL + Arrow Key
  {
    key = 'LeftArrow',
    mods = 'ALT|CTRL',
    action = split_pane('Left'),
  },
  {
    key = 'RightArrow',
    mods = 'ALT|CTRL',
    action = split_pane('Right'),
  },
  {
    key = 'UpArrow',
    mods = 'ALT|CTRL',
    action = split_pane('Top'),
  },
  {
    key = 'DownArrow',
    mods = 'ALT|CTRL',
    action = split_pane('Bottom'),
  },

  -- Activate the pane in the specified arrow direction using ALT + Arrow Key
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection "Down",
  },

  -- Move active pane to a new tab using Ctrl + Shift + K
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local new_tab, _ = pane:move_to_new_tab()
      new_tab:activate()
    end),
  },

  -- Ctrl + Shift + Left/Right Arrow: Navigate tabs (no wrap-around)
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelativeNoWrap(-1),
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelativeNoWrap(1),
  },

  -- Shift + Alt + Left/Right Arrow: Move/swap current tab position (no wrap-around)
  {
    key = 'LeftArrow',
    mods = 'SHIFT|ALT',
    action = move_tab_no_wrap(-1),
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT|ALT',
    action = move_tab_no_wrap(1),
  },

  -- Ctrl + Left/Right Arrow: Move cursor one word left or right (depending on the arrow pressed)
  {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = 'b', mods = 'ALT' } -- Alt+b -> backward-word
  },
  {
    key = 'RightArrow',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = 'f', mods = 'ALT' } -- Alt+f -> forward-word
  },

  -- Ctrl + Backspace: Delete the word to the left of the cursor
  {
    key = 'Backspace',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = 'Backspace', mods = 'ALT' } -- By default, that behaviour is with ALT+Backspace, so I map CTRL+Backspace to do ALT+Backspace
  },

  -- Ctrl + Shift + f: search.
  -- In a full-screen program (Neovim, less, man...) WezTerm can only see the visible screen,
  -- so hand the search to the program (as Alt+/). In a normal shell, use WezTerm's own search.
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      if pane:is_alt_screen_active() then
        window:perform_action(wezterm.action.SendString '\x1b/', pane)
      else
        window:perform_action(wezterm.action.Search { CaseInSensitiveString = '' }, pane)
      end
    end),
  },

}



-----------------------------------------------------------------------
---------- Return the config
-----------------------------------------------------------------------

return config