-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

-- Configuración de Codeium
local codeium_ok, codeium = pcall(require, "codeium")

if codeium_ok then
    codeium.setup({
        -- Por defecto, habilita el autocompletado en insert mode.
        enable_chat = true,

        virtual_text = {
            enabled = true,

            key_bindings = {
                accept = "<Tab>",    -- Aceptar la sugerencia completa
                next = "<M-n>",      -- Siguiente sugerencia (Alt + n)
                prev = "<M-p>",      -- Sugerencia anterior (Alt + p)
                clear = "<C-x>",     -- Limpiar/Ocultar la sugerencia (Ctrl + x)
            }
        }
    })
else
    print("Error: No se pudo cargar codeium.nvim")
end

-- Configuración de Avante.nvim (con Ollama)
local avante_ok, avante = pcall(require, "avante")

if avante_ok then
    avante.setup({
        provider = "mi_ollama",
        auto_suggestions_provider = "mi_ollama",

        providers = {
            mi_ollama = {
                __inherited_from = "openai",
                api_key_name = "", 
                endpoint = "http://127.0.0.1:3000/v1",
                model = "rnj-1:8b",

                parse_curl_args = function(opts, code_opts)
                    return {
                        url = opts.endpoint .. "/chat/completions",
                        
                        headers = {
                            ["Accept"] = "application/json",
                            ["Content-Type"] = "application/json",
                        },

                        body = {
                            model = opts.model,
                            messages = require("avante.providers").copilot.parse_messages(code_opts),
                            max_tokens = 2048,
                            stream = true,
                        },
                    }
                end,
            }
        },
        behaviour = {
            auto_suggestions = false,
            auto_set_keymaps = false, 
            auto_set_highlight_group = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
        },
    })

    -- --- Mapeos de Teclas para Avante ---
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Modo Normal
    map("n", "<leader>aa", function() require("avante.api").ask() end, { desc = "Avante: Abrir Chat", noremap = true, silent = true })
    map("n", "<leader>ar", function() require("avante.api").refresh() end, { desc = "Avante: Refrescar/Limpiar Chat", noremap = true, silent = true })
    
    -- Modo Visual (Para refactorizar o preguntar sobre un bloque de código específico)
    map("v", "<leader>ae", function() require("avante.api").edit() end, { desc = "Avante: Editar código seleccionado", noremap = true, silent = true })
    map("v", "<leader>aa", function() require("avante.api").ask() end, { desc = "Avante: Preguntar sobre selección", noremap = true, silent = true })
    
else
    print("Error: No se pudo cargar avante.nvim")
end

-- Configuración de Render Markdown (Dependencia de Avante)
local render_ok, render_markdown = pcall(require, "render-markdown")

if render_ok then
    render_markdown.setup({
        file_types = { "markdown", "Avante" },
    })
end