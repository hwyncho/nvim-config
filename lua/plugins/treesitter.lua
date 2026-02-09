return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            require("nvim-treesitter").setup {
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "python",
                    "go",
                    "javascript",
                    "typescript",
                    "tsx",
                    "bash",
                    "html",
                    "css",
                    "json",
                    "yaml",
                    "toml",
                    "markdown",
                    "markdown_inline",
                    "dockerfile",
                    "java",
                    "kotlin",
                },
                auto_install = true,
            }

            -- Treesitter-based folding (optional)
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt.foldenable = false

            -- Incremental selection keymaps
            local map = vim.keymap.set
            map("n", "<C-space>", function()
                require("nvim-treesitter.incremental_selection").init_selection()
            end, { desc = "Init treesitter selection" })
            map("x", "<C-space>", function()
                require("nvim-treesitter.incremental_selection").node_incremental()
            end, { desc = "Increment treesitter selection" })
            map("x", "<bs>", function()
                require("nvim-treesitter.incremental_selection").node_decremental()
            end, { desc = "Decrement treesitter selection" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "V",
                    },
                },
                move = {
                    set_jumps = true,
                },
            }

            -- Textobject keymaps
            local map = vim.keymap.set
            map({ "x", "o" }, "af", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end, { desc = "Select outer function" })
            map({ "x", "o" }, "if", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end, { desc = "Select inner function" })
            map({ "x", "o" }, "ac", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end, { desc = "Select outer class" })
            map({ "x", "o" }, "ic", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end, { desc = "Select inner class" })
            map({ "x", "o" }, "aa", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
            end, { desc = "Select outer parameter" })
            map({ "x", "o" }, "ia", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
            end, { desc = "Select inner parameter" })

            -- Move keymaps
            local move = require "nvim-treesitter-textobjects.move"
            map({ "n", "x", "o" }, "]m", function()
                move.goto_next_start("@function.outer", "textobjects")
            end, { desc = "Next function start" })
            map({ "n", "x", "o" }, "]M", function()
                move.goto_next_end("@function.outer", "textobjects")
            end, { desc = "Next function end" })
            map({ "n", "x", "o" }, "]]", function()
                move.goto_next_start("@class.outer", "textobjects")
            end, { desc = "Next class start" })
            map({ "n", "x", "o" }, "][", function()
                move.goto_next_end("@class.outer", "textobjects")
            end, { desc = "Next class end" })
            map({ "n", "x", "o" }, "[m", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end, { desc = "Previous function start" })
            map({ "n", "x", "o" }, "[M", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end, { desc = "Previous function end" })
            map({ "n", "x", "o" }, "[[", function()
                move.goto_previous_start("@class.outer", "textobjects")
            end, { desc = "Previous class start" })
            map({ "n", "x", "o" }, "[]", function()
                move.goto_previous_end("@class.outer", "textobjects")
            end, { desc = "Previous class end" })
        end,
    },
}
