-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

local function strip_ansi(text)
    if type(text) ~= "string" then return text end
    local s, _ = text:gsub("\27%[[%?0-9;]*%a", "")
    return s
end

local function get_onefetch()
    local cmd = "TERM=dumb onefetch 2>/dev/null"
        
    local git_check = vim.fn.systemlist("git rev-parse --is-inside-work-tree 2>/dev/null")
    if type(git_check) ~= "table" or git_check[1] ~= "true" then
        return { " ", "   󱄅  Bienvenido, Luis", " ", "   No se detectó un repositorio Git." }
    end

    local raw_output = vim.fn.systemlist(cmd)
    local clean_output = {}

    if type(raw_output) == "table" and #raw_output > 0 then
        for _, line in ipairs(raw_output) do
            table.insert(clean_output, (strip_ansi(line)) )
        end
        return clean_output
    end

    return { 
        " ", 
        "   󱄅  Bienvenido, Luis", 
        " ", 
        "   Error al cargar estadísticas." 
    }
end

dashboard.section.header.val = get_onefetch()

vim.api.nvim_set_hl(0, 'AlphaHeaderColor', { fg = "${config.colors.skyblue}" })
dashboard.section.header.opts.hl = "AlphaHeaderColor"

dashboard.section.buttons.val = {
    dashboard.button("p", "󰄉  Proyectos", ":Telescope project<CR>"),
    dashboard.button("f", "󰈞  Buscar archivos", ":Telescope find_files<CR>"),
    dashboard.button("q", "󰅚  Salir", ":qa<CR>"),
}

alpha.setup(dashboard.config)