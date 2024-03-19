local M = {}

--- Get an icon from the AstroNvim internal icons if it is available and return it
---@param kind string The kind of icon in astronvim.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@return string icon
function M.get_icon(kind, padding, fallback)
    M.icons = require "icons.nerd_font"
    M.text_icons = require "icons.text"
    local icon = M["icons"] and M["icons"][kind]
    return icon and icon .. string.rep(" ", padding or 0) or ""
end

--- Create a button entity to use with the alpha dashboard
---@param sc string The keybinding string to convert to a button
---@param txt string The explanation text of what the keybinding does
---@return table # A button entity table for an alpha configuration
function M.alpha_button(sc, txt)
    -- replace <leader> in shortcut text with LDR for nicer printing
    local sc_ = sc:gsub("%s", ""):gsub("LDR", "<Leader>")
    -- if the leader is set, replace the text with the actual leader key for nicer printing
    if vim.g.mapleader then sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader) end
    -- return the button entity to display the correct text and send the correct keybinding on press
    return {
        type = "button",
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = {
            position = "center",
            text = txt,
            shortcut = sc,
            cursor = -2,
            width = 36,
            align_shortcut = "right",
            hl = "DashboardCenter",
            hl_shortcut = "DashboardShortcut",
        },
    }
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--- Serve a notification with a title of Gavin
---@param msg string The notification body
---@param type? number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
    vim.schedule(function() vim.notify(msg, type, M.extend_tbl({ title = "Gavin" }, opts)) end)
end

-- Close every floating window
M.close_floating_windows = function()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == 'win' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

return M
