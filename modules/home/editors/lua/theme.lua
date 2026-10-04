-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

-- Custom Theme: Verdigris

local colors = {
    black     = _G.NixVars.black,
    white     = _G.NixVars.white,
    grey      = _G.NixVars.grey,
    darkblue  = _G.NixVars.darkblue,
    lightblue = _G.NixVars.lightblue,
    green     = _G.NixVars.green,
    sand      = _G.NixVars.sand,
    red       = _G.NixVars.red,
    lavanda   = _G.NixVars.lavanda,
}

local set = vim.api.nvim_set_hl

-- Editor

set(0, "Normal", {
    fg = colors.white,
    bg = colors.black,
})

set(0, "NormalFloat", {
    fg = colors.white,
    bg = colors.black,
})

set(0, "FloatBorder", {
    fg = colors.grey,
    bg = colors.black,
})

set(0, "Cursor", {
    fg = colors.black,
    bg = colors.white,
})

set(0, "CursorLine", {
    bg = "#1b1917",
})

set(0, "CursorLineNr", {
    fg = colors.white,
    bold = true,
})

set(0, "LineNr", {
    fg = colors.grey,
})

set(0, "Visual", {
    bg = "#302b29",
})

set(0, "Search", {
    fg = colors.black,
    bg = colors.sand,
})

set(0, "IncSearch", {
    fg = colors.black,
    bg = colors.lightblue,
})

set(0, "MatchParen", {
    fg = colors.sand,
    bold = true,
})

set(0, "NonText", {
    fg = colors.grey,
})

set(0, "Whitespace", {
    fg = "#3a3432",
})

-- Syntax

set(0, "Comment", {
    fg = colors.grey,
    italic = true,
})

set(0, "String", {
    fg = colors.sand,
})

set(0, "Character", {
    fg = colors.sand,
})

set(0, "Number", {
    fg = colors.red,
})

set(0, "Float", {
    fg = colors.red,
})

set(0, "Boolean", {
    fg = colors.red,
})

set(0, "Constant", {
    fg = colors.red,
})

set(0, "Keyword", {
    fg = colors.green,
})

set(0, "Statement", {
    fg = colors.green,
})

set(0, "Conditional", {
    fg = colors.green,
})

set(0, "Repeat", {
    fg = colors.green,
})

set(0, "Operator", {
    fg = colors.green,
})

set(0, "Function", {
    fg = colors.lavanda,
})

set(0, "Identifier", {
    fg = colors.white,
})

set(0, "Type", {
    fg = colors.darkblue,
})

set(0, "Structure", {
    fg = colors.darkblue,
})

set(0, "StorageClass", {
    fg = colors.darkblue,
})

set(0, "Special", {
    fg = colors.lightblue,
})

set(0, "Delimiter", {
    fg = colors.white,
})

set(0, "PreProc", {
    fg = colors.lightblue,
})

set(0, "Todo", {
    fg = colors.black,
    bg = colors.sand,
    bold = true,
})

-- Treesitter

-- Comments
set(0, "@comment", {
    link = "Comment",
})

-- Strings
set(0, "@string", {
    link = "String",
})

set(0, "@string.escape", {
    fg = colors.lightblue,
})

set(0, "@string.special", {
    fg = colors.lightblue,
})

-- Constants
set(0, "@constant", {
    link = "Constant",
})

set(0, "@constant.builtin", {
    fg = colors.red,
})

set(0, "@boolean", {
    link = "Boolean",
})

set(0, "@number", {
    link = "Number",
})

-- Keywords
set(0, "@keyword", {
    link = "Keyword",
})

set(0, "@keyword.function", {
    fg = colors.green,
})

set(0, "@keyword.return", {
    fg = colors.green,
})

set(0, "@keyword.operator", {
    fg = colors.green,
})

set(0, "@conditional", {
    fg = colors.green,
})

set(0, "@repeat", {
    fg = colors.green,
})

-- Functions
set(0, "@function", {
    link = "Function",
})

set(0, "@function.call", {
    fg = colors.lavanda,
})

set(0, "@function.builtin", {
    fg = colors.lavanda,
})

set(0, "@method", {
    fg = colors.lavanda,
})

set(0, "@method.call", {
    fg = colors.lavanda,
})

-- Types
set(0, "@type", {
    link = "Type",
})

set(0, "@type.builtin", {
    fg = colors.darkblue,
})

set(0, "@constructor", {
    fg = colors.darkblue,
})

-- Variables
set(0, "@variable", {
    fg = colors.white,
})

set(0, "@variable.builtin", {
    fg = colors.darkblue,
})

set(0, "@variable.parameter", {
    fg = colors.white,
})

set(0, "@property", {
    fg = colors.lightblue,
})

set(0, "@field", {
    fg = colors.lightblue,
})

-- Operators / punctuation
set(0, "@operator", {
    link = "Operator",
})

set(0, "@punctuation.delimiter", {
    fg = colors.grey,
})

set(0, "@punctuation.bracket", {
    fg = colors.grey,
})

set(0, "@punctuation.special", {
    fg = colors.lightblue,
})

-- LSP Semantic Tokens

set(0, "@lsp.type.function", {
    fg = colors.lavanda,
})

set(0, "@lsp.type.method", {
    fg = colors.lavanda,
})

set(0, "@lsp.type.keyword", {
    fg = colors.green,
})

set(0, "@lsp.type.string", {
    fg = colors.sand,
})

set(0, "@lsp.type.number", {
    fg = colors.red,
})

set(0, "@lsp.type.type", {
    fg = colors.darkblue,
})

set(0, "@lsp.type.class", {
    fg = colors.darkblue,
})

set(0, "@lsp.type.interface", {
    fg = colors.darkblue,
})

set(0, "@lsp.type.variable", {
    fg = colors.white,
})

set(0, "@lsp.type.property", {
    fg = colors.lightblue,
})

set(0, "@lsp.type.parameter", {
    fg = colors.white,
})

-- Diagnostics

set(0, "DiagnosticError", {
    fg = colors.red,
})

set(0, "DiagnosticWarn", {
    fg = colors.sand,
})

set(0, "DiagnosticInfo", {
    fg = colors.lightblue,
})

set(0, "DiagnosticHint", {
    fg = colors.green,
})

set(0, "DiagnosticUnderlineError", {
    undercurl = true,
    sp = colors.red,
})

set(0, "DiagnosticUnderlineWarn", {
    undercurl = true,
    sp = colors.sand,
})

set(0, "DiagnosticUnderlineInfo", {
    undercurl = true,
    sp = colors.lightblue,
})

set(0, "DiagnosticUnderlineHint", {
    undercurl = true,
    sp = colors.green,
})

-- Git

set(0, "GitSignsAdd", {
    fg = colors.green,
})

set(0, "GitSignsChange", {
    fg = colors.lightblue,
})

set(0, "GitSignsDelete", {
    fg = colors.red,
})

-- Completion

set(0, "Pmenu", {
    fg = colors.white,
    bg = "#1b1917",
})

set(0, "PmenuSel", {
    fg = colors.black,
    bg = colors.lightblue,
})

set(0, "PmenuSbar", {
    bg = "#292522",
})

set(0, "PmenuThumb", {
    bg = colors.grey,
})

set(0, "CmpItemAbbrDeprecated", {
    fg = colors.grey,
    strikethrough = true,
})

-- UI

set(0, "StatusLine", {
    fg = colors.white,
    bg = "#1b1917",
})

set(0, "StatusLineNC", {
    fg = colors.grey,
    bg = colors.black,
})

set(0, "WinSeparator", {
    fg = "#292522",
    bg = colors.black,
})

set(0, "VertSplit", {
    fg = "#292522",
    bg = colors.black,
})

set(0, "Folded", {
    fg = colors.grey,
    bg = "#1b1917",
})

set(0, "Title", {
    fg = colors.lavanda,
    bold = true,
})