--https://github.com/f0ur3y3s
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function command_exists(cmd)
    local handle = io.popen("which " .. cmd .. " 2>/dev/null")
    if not handle then return false end
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
end

local function get_fortune()
    if command_exists("fortune") and command_exists("cowsay") then
        local handle = io.popen("fortune -s | cowsay")
        if handle then
            local result = handle:read("*a")
            handle:close()
            return result
        end
    end

    return [[
   ╭─────────────────────────────╮
   │         Welcome back!       │
   ╰─────────────────────────────╯
    ]]
end

dashboard.section.header.val = vim.split(get_fortune(), "\n")
dashboard.section.header.opts.hl = "AlphaHeader"

dashboard.section.buttons.val = {
    dashboard.button("n", "󰈔  New File", ":ene <BAR> startinsert<CR>"),
    dashboard.button("SPC f f", "󰈞  Fuzzy Find", ":Telescope find_files<CR>"),
    dashboard.button("SPC f r", "󰄉  Recent Files", ":Telescope oldfiles<CR>"),
    dashboard.button("SPC f g", "󰊄  Fuzzy Grep", ":Telescope live_grep<CR>"),
    dashboard.button("q", "󰈆  Quit", "<cmd>q!<cr>"),
}

dashboard.section.footer.val = { os.date(" %A %B %x") }
dashboard.section.footer.opts.hl = "AlphaFooter"

dashboard.config.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
}

return dashboard
